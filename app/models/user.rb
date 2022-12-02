class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #↓フォローした/されたの関係
  has_many :relationships,class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :re_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #↓フォロー/フォロワー一覧画面で使うアソシエーション
  has_many :followings,through: :relationships, source: :followed
  has_many :followers,through: :re_relationships, source: :follower

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #フォローした時の処理
  def follow(user_id)
    unless self == user_id #フォローしようとしているuser_idが自分ではないか？をチェック
      self.relationships.find_or_create_by(followed_id: user_id.to_i, follower_id: self.id)
    end
  end

  #フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  #フォローしているかどうか判定
  def following?(user)
    followings.include?(user)
  end


  #検索方法の分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end


end

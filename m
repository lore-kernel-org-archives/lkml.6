Return-Path: <kernel-hardening-return-12605-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv+3j8NgWAe4nVrrqXVOaYw5LazTvOZsQv71AOoylwWJphAEdg8f5Eq3yUymAHtaWzlQyAW
ARC-Seal: i=1; a=rsa-sha256; t=1521044266; cv=none;
        d=google.com; s=arc-20160816;
        b=I6Ymq0AvzVem17It/da4xf7A04qNyk3FuJagdsChL/DeUEiV1y/UsDm2mVQ1zGj/33
         6T8cpzg7pfBPsDUBA0qdIO7yKY/8Dm/+tW8cl+QAjyyqzM4LtgOB7E6OVj7IlHr1FOvt
         zcuwJys3o9HBBbQRvT46JFBB9Xu9lPo5A8/xcVv/mlAEeOehv9v4Frn6A6OyPi13HDFB
         6P8GRHftTil8NWhEAEhNcgxzWEBgBODz4nP/qlfU5H/eHkmqd+Kl9IHaFIebV02LQ4H/
         zd9PvRN+xoOl7cxHl0CQbWJjaVDn7UY7a9auJ49V/7t9dxgC1dYkUw2nHHr1seqbxtL7
         +IsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=frKCdxzUZKK6ncnnNvQDmfOl1cK2Su4ig1lOptGxQ64=;
        b=T0zyItGjaXNq0GuTC0iJNLO8QRYCMR617M6J9MXKd9Tc041LNbMIPdazROX0db0mPb
         5siHIKC0hK5NEroLElusYEWw0hnQMH+wLZrnxaDdYlj3vUSORWjwfXyeoVZp2ybkmy95
         Xv+srSPrqpFmgs20igk54n9g6Fn2MYAKgkII3fmHP8/K7IVPy6atXNpYH2LWeJq9g9+i
         zwGHYZ46Hn2e2cqiDLvePzBnTRCt1Xo51puXwcboRRqTia14ZpnbwTSVgB8JhI/SrLpH
         YRtM6gwpER6Lbqk2OMAfzs8WkY2S5NR3WEB8tdZYeer/tVz4S9i6LgZigS/EvyM8nrEt
         UFKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jQNt+WVl;
       spf=pass (google.com: domain of kernel-hardening-return-12605-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12605-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jQNt+WVl;
       spf=pass (google.com: domain of kernel-hardening-return-12605-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12605-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180314154248.GL32007@twin.jikos.cz>
References: <1520970622-19535-1-git-send-email-s.mesoraca16@gmail.com> <20180314154248.GL32007@twin.jikos.cz>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Wed, 14 Mar 2018 17:17:06 +0100
Message-ID: <CAJHCu1LFy+dpAvBw+Qgp-wCOg8=Fx8NUM-ovVSMjfoGf9E7sMw@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: drop a VLA in btrfs_check_super_csum()
To: dsterba@suse.cz, Salvatore Mesoraca <s.mesoraca16@gmail.com>, linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-btrfs@vger.kernel.org,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Josef Bacik <jbacik@fb.com>,
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853328339341486?=
X-GMAIL-MSGID: =?utf-8?q?1594930512595577141?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-14 16:42 GMT+01:00 David Sterba <dsterba@suse.cz>:
> We already have a patch for that from a few days ago, but thanks anyway.
>
> https://patchwork.kernel.org/patch/10277901/

Oh.. OK

Best regards,

Salvatore

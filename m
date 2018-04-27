Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524839362; cv=none;
        d=google.com; s=arc-20160816;
        b=uJHWfHch+o3KYzYmhUCvs+SkgOR69LfUeQ2EiX4wXQSFfYLi1gp8zBVpUF31Zf4yFJ
         zUoRm+8m7cVQx5IKkXPcg8QfGpo00sLPFRtZQDZLqA6Ga2YVgQFD8k54KoBwYSL4BEm5
         SdiwccXrf/pbkPeKFknexLS1swMQlkI1FI7+AteOMdSGJR8hx3uhwdsha6ZNe3jbDFUH
         6qtkU3by5TOCDJsLx8uz0VOGEGd/FwRs+5amjna0G4UjocLVTP1iSmPMXoYnmgMttpJM
         cJzwqwnsfb/65Sz5HdkyZ0Rj0yFtbz1yxnxwQUJOrZ6JpMzjKUsBs6ZUY8osKzXJ20px
         RW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=yi+Il2SVA+W8dXStw2wChDp3pU9c1DhwtbaU61PU0sM=;
        b=iIlUzFPRCNytNWByxy7pFZpbOjoGyw2BN1ZYrCYD4j8pW4eiY/661iaM4qs9c8UuN4
         ydojmWEGkU0KWWHDkPRLsmBIt5Dg8ldIR8tzyWmG5GU1lrNOqb3vhsg0ZXNRT4acJJAu
         9jYd4eqwuUFZaGihfeNdMZ4eQKm4iA82QzwW517Hrc+jFFfm6VJgqht0fBWeLZvBY0P5
         RamGn5xnbmGe2EDUCpf81cY/r0ZGrXACB36IBVv/3wkSorXj4iB0MBk86mKxLYtU0RwY
         UWZumM5vxJmCqdoqySM1uVO+gF5Tn5pNS2XcIfQJMW6vrlhz5gQNLVWs86C9Utn/uR6J
         peHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZozgYQ5iuKHj/oWxiWHO8FMtjgmuQTODJcBTHUswiYidFaCNHabcsaId6LRYuCmmLFSn28VBQ==
Date: Fri, 27 Apr 2018 09:29:17 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>, Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: iio: afe: add binding for
 voltage-divider
Message-ID: <20180427142917.zdtopxwy72snrv2q@rob-hp-laptop>
References: <20180423210809.29586-1-peda@axentia.se>
 <20180423210809.29586-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423210809.29586-3-peda@axentia.se>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598572688738180066?=
X-GMAIL-MSGID: =?utf-8?q?1598909959508209992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 11:08:07PM +0200, Peter Rosin wrote:
> An ADC is often used to measure other quantities indirectly. This
> binding describe one cases, a "big" voltage measured with the help
> of a voltage divider.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/iio/afe/voltage-divider.txt           | 53 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt

Reviewed-by: Rob Herring <robh@kernel.org>

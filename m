Return-Path: <vinod.koul@intel.com>
X-Google-Smtp-Source: AIpwx48VtgMhLHwRjZJokz0rLjDxvaENj3jnCYTibzNGYioVJu9g1MH92PJYJaptyiyvdV2bDlYo
ARC-Seal: i=1; a=rsa-sha256; t=1524378479; cv=none;
        d=google.com; s=arc-20160816;
        b=lUQctnz29gwtnlyClwHU4gqA0BeicBthjjkPCRhbMX4nwhMwgDfvKh0Skre5yNFphL
         rl8n9cDroA1yaGYBUrwAoayMQmVJ/MQPJF3c9yemg8e9vqwGNQSAb62XE3c+gIDmgrSe
         i371Lz0auhPKjqNwczr1ueqaQqxztUK2ehIb2d6J3Bhyc3IdknJTq0LN8oGAINvFd40U
         ZGvZDtPULZOAOdBlP290DkuS2s9MlbrT3K4XKKhWjqP/BjvnfJPK7B8/3BVW2ioUmuyo
         r9hbh1fmfq9Hbric52stqX+WKTWN80zYNTp/tXtubUa24O1B+7z6DTQmgMFVtp1+iiCb
         IYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=TC4I+weZYI7EE5f0pU80VlI7ygSHpRiU0HvhZJZv+TM=;
        b=IztvUfS+J5v384Y6j7UA92Y139uwl9fsSdL6fCjabEi/4VGy1+eipNtINIJsHI2I8D
         h/ij6yYVXPqybUNyhdsZCP6RUOucp7ZD+um9kwT8zGVPSnX1vVHyAfHF3KoWdeRytPCU
         Uxyj08Wk9n3tmbb5N+z+3Al1kHLoo20p+pxptnrPbxsSzNGx3IOT0iK9PRVtu4NQejVN
         9iRWQby2XV7kNv6iu9bfqnwUOFW0Fp2L2cuUpeWsiBYeH0XDHBWDT3dAKSgR3lIv7sEc
         Xk/WiFva4MgDssFfIFuiad9m1i91unr0ISrG50g0Sqi0e+hbf90rOASfATb6QEcY7S6/
         4ATA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,310,1520924400";
   d="scan'208";a="45110498"
Date: Sun, 22 Apr 2018 12:02:32 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: dmaengine@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add maintainer for Qualcomm HIDMA drivers
Message-ID: <20180422063232.GX6014@localhost>
References: <1524151261-13461-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524151261-13461-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598188443339699993?=
X-GMAIL-MSGID: =?utf-8?q?1598426688139080329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 11:20:32AM -0400, Sinan Kaya wrote:
> drivers/dma/qcom directory is being shared by multiple QCOM dmaengine
> drivers. Separate ownership by filenames.

Applied, thanks

-- 
~Vinod

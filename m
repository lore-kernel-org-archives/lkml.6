Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrOwnlLMGWJ4Qo/MERh+ZCYjiCKYxNdB9Tuo/sR3L6j7totzhpPSRFMBxIi3PdI+BMIBaZT
ARC-Seal: i=1; a=rsa-sha256; t=1526295527; cv=none;
        d=google.com; s=arc-20160816;
        b=xa1cqk9rTsdydw1FFWAHsK6uJ2ZMnAuWAOysH12+ePgb+tHghkwmuf1qiivFcwGhrQ
         ODf0IKwjoXqhgJ+pCF2HgClimdCTmQH8OKRyGuj9MU/pPZ5SqGC2TvCD+KaZt0i87xOh
         HsAiG90ad48onqOZcdaNquiVH85jO3KKjmWObzrB9Ip07qX5F2ERzQ8J7YlqQ/OuYxgD
         LBgqp/0LXMt8TxHWO1XseVXripU92W9ZMnop0gEWVM3PEZNOs0Trm3DFlC3y9FMrF3t+
         rb388TBxXdhZuyzlLkuc8wXCOnQrfdVS9TTtTLuAe/H6F0BTDHlNFm3s71cTGILjP9o9
         eI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=a/zndeeuicuAWJ7aqpeJh1N+qTqjpWV3/l+szb4516M=;
        b=gQatMcEt8m5FVv0heO3LsXXaiC7E8QozJUvRIgYflIqYoDPTDYauHCbx7I0D2mbb+i
         Wv+WrkeDvhmbU5NwsD6vYdompPPdEFsSDg2vx/kqaz5ysEn3lOoG7sQTx+rG+yTgyRc1
         8JyMVIVnLTWF4p6igBj4R+UBnSe2bW5HT7YR8Y5l3LLtB8KS2YcwA98oLpawMfZFfyTN
         sOgcHxFJMUeymRi/kRjAIPICprXQ9iCzvQswJcDOAUK0G+O2/HthTLBe/yvMqqzIKKuJ
         +/k2BcstDyF+WHnFOWI5N4t1oJOsz0fVaGfnbzZlHivBr8FaPG4vgK2/OMTS7lpPnwWk
         Gk3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="228349733"
Date: Mon, 14 May 2018 13:58:39 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Cc: peterhuewe@gmx.de, tweek@google.com, jgg@ziepe.ca, arnd@arndb.de,
	gregkh@linuxfoundation.org, javierm@redhat.com,
	sonnyrao@chromium.org, enric.balletbo@collabora.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: replace kmalloc() + memcpy() with kmemdup()
Message-ID: <20180514105839.GH8228@linux.intel.com>
References: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
 <CGME20180509001300epcas2p3971900d48408aef6a80f59b9480aac16@epcas2p3.samsung.com>
 <1525824757-21835-2-git-send-email-ji_hun.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525824757-21835-2-git-send-email-ji_hun.kim@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599943245926622446?=
X-GMAIL-MSGID: =?utf-8?q?1600436858836950511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 09:12:37AM +0900, Ji-Hun Kim wrote:
> Use kmemdup rather than duplicating its implementation.
> 
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>

/Jarkko

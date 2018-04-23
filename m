Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AIpwx49FQ8qnrPCacSlqXwzigDLNGXSeKzkjmPuE3a8tSnZ4eU9M0qTQ00HdWgRKlhOi8s16RZZ3
ARC-Seal: i=1; a=rsa-sha256; t=1524512948; cv=none;
        d=google.com; s=arc-20160816;
        b=VxPulrK5NTINrxoGn6f7bvzYFlnoTW6JdjRtCOaEHaiDcxy9nXS46XceJMBTMiDh3X
         2cDIBiT6lWicoI2UjKNX5ARcTbavp2HxzKLJDLUzU2hO2g9k+CWS02t8haCumwtlEVjr
         5pvRgNgBPt5yOW+9FN7/uZDEbnejYV/V2vQneAT/DihQsM/DHolrcORqCz53ksLyaHeT
         LMrqBUAXGJSbjCvSvWv0dUkdiAQG+p1yiSRg5npRmalLvuuBwCiCruifYhbkXN8SaAwH
         I1i2/dPLtZRoSLHXAMP5gKEFebukknIRFAkluppXgbTkfXYgR0mAAko1xjLmSvSZdeqx
         3Jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=opoSup042P+ilapHpGrwcmUzTSMbpfyBbbHvGoqHDzY=;
        b=raNvwmzOIF1zxONbmeOOK2/74Im7IJPu6sOoIAIaNfF5+L0WC7/76nwWkpHZSzH8H0
         L18KDc7yJuwyPp/QLOPRJTiAUm5N/2YWkKZuJZ+bNuFPMxNGMrGHVGMgfVLiC7+fJIgt
         Lqyxpek3/tJz29LkBvwFdaYHgfjmQvlZEIrhMJ7qfSyHGBlJuGF4O102Q3tidHAx/K3n
         CXApxoOkrzJbN0gb4Az192s/+yx5DcDFFcVuC5LPJj3YRPMMTQ7O6wmSssrgv3Q91Usi
         l98Arbl10AhKDPtipbcQOiZtMO2iAMgghsUauRu7Z6+VE/n7tckA+2dl6dPvCRkZl7oa
         DXtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,319,1520924400";
   d="scan'208";a="35822489"
Date: Mon, 23 Apr 2018 22:49:01 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Colin King <colin.king@canonical.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-integrity@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/st33zp24: Fix spelling mistake in macro
 ST33ZP24_TISREGISTER_UKNOWN
Message-ID: <20180423194849.GC7653@linux.intel.com>
References: <20180418112105.894-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418112105.894-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598082745288242263?=
X-GMAIL-MSGID: =?utf-8?q?1598567689212829960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 12:21:05PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Fix spelling mistake, rename ST33ZP24_TISREGISTER_UKNOWN to
> ST33ZP24_TISREGISTER_UNKNOWN
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

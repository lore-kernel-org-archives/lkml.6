Return-Path: <alexander.shishkin@linux.intel.com>
X-Google-Smtp-Source: AIpwx48YJjhHBgRs0zR1S1+7DgbxK99/COxD4i4Y6cx+q0PLKCY4luHt5iX9W7BZdwpm7gJ7F0Td
ARC-Seal: i=1; a=rsa-sha256; t=1524136674; cv=none;
        d=google.com; s=arc-20160816;
        b=t1XxQcrMHNYhM2Q1EbfSP+goVH8dAjFywn23GYCFDLbB1UdaKvfC+P6pN+U9LEBcrj
         FW4jd3NmcIQsa3p4MRZ0feAZOZwy4tyYwVxQva9TNpgwO3iCDXYOGuo6O2HxcxvPWEJc
         l2V6WN4FNHkPu2x8UYeF9Aj08RN+UnQ3GpvZKtBN8b61UkFzrGN/Er3IT6D3jQXdejRU
         cZGU8I5WW0ARFlgvghir8ZGwIVf+fmq0ylIZnlyQLB3chJ6+dXMGrC142doo4r33qQAp
         CTg4wloqz4UChNrSWLj37z0GE4RsyRe8gc4jNz7LCFlwFZ4cQIvslaaQg1Y2eGABdqin
         h37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=UiJnMuJLGVtO4e77uZQSg/j2Vgg0W+7y09pVZwL0Ggc=;
        b=ktu7cwrJszWlbl+VKTUYMgSoxqMEoyyu8aqVNtXG0BZZhnxYekTTtB0leoaeA/2dMo
         RP77GQrykYBnsksh+hr8gGlE34NerCs/nq/BIcdBld4e1JLYFSYx72mQWnQiMrWoMFq5
         5ePbW06o0FcgL0U1t44EhTs906VDk7juc/60B5+ItBdU1DxEkFt0ISrEPdYq1WU5gAmZ
         JSYLM8jXPOX7fjPZP6x35c8PN6qVEyg34duouX5/xkacNHPXIMsVIxehrbyb4Orb0qeA
         nvJZEYv2ZxxCKTfhwt8EcsRTpwRy3Ofzga1e1PQ9Ex5QvENG9UZBWEqDfNU2rNH/5+V4
         dkeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of alexander.shishkin@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=alexander.shishkin@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of alexander.shishkin@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=alexander.shishkin@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,468,1517904000";
   d="scan'208";a="44488971"
Date: Thu, 19 Apr 2018 14:17:50 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
	leo.yan@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: Moving framework and drivers to SPDX
 identifier
Message-ID: <20180419111750.q2gfdjkj7bcx7hz5@um.fi.intel.com>
Mail-Followup-To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
	leo.yan@linaro.org, linux-kernel@vger.kernel.org
References: <1523981817-16176-1-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523981817-16176-1-git-send-email-mathieu.poirier@linaro.org>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597937409545454672?=
X-GMAIL-MSGID: =?utf-8?q?1598173138179568557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 10:16:57AM -0600, Mathieu Poirier wrote:
> Moving all kernel side CoreSight framework and drivers to SPDX identifier.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

For the stm bit:

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thanks,
--
Alex

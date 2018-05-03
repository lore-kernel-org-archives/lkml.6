Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AB8JxZrdWRBsEtWnvwqa5DzVnJPjHT+34Rleq77w14HnWya+DU4mX567R52URbjua8+dz43us+l4
ARC-Seal: i=1; a=rsa-sha256; t=1525349931; cv=none;
        d=google.com; s=arc-20160816;
        b=kpw84N4P+PUelBCKJi4pDlKV9cQi8fU9KFasDeNgEHtLh5CX5iWMGFUEpCqIbmiSAh
         MyXe0y5gal7ZmUoBui8t44Oaf0DWFbkpdg4ZRUsOvKJeWwCYa06T88WhEzmQ3pYsldaj
         1+bbuxXEuoUugm47GJob0XPxVrV68kGF9JSGZFE3nWshwBI+oXuoBgd/B3V7B2BJYtQo
         EG2XiCVO3HbXP+SvmY/unqpQSLB8qaQ57LA8bpr3TwWBpUbwRUc9I20qav4mRmzhlDEj
         /Q2hB22Q1yfx7jPermSREuEgHGdCyNgwNXQPUM3CgAVLbY9ViOiXNQgGk1DKGtTfRGjo
         ceMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=dfV4S+tIfSLRut/pUgxnCYN19qQBWskzIL/ZLW3N9xo=;
        b=Uhb8Gr3/y8EGEo9hKGq7R6RcTgAd9oLp052fZnED3jxwUpfQd5bdtgtuei9NCjlGKR
         nfzJ7zceyVXSXm5IpdtYcKE340UaOpyv9t4i7ZUVe5/t/yRBoFksFLbSlTwbvT57QGPg
         AlggEEF7zznJ/jo6o16RiiGUsw1seaOj0p4CRzHs2eLOdAzr1jEqBEsvWaPnVEDgnUug
         Jc5jDEzt1fFTlmme3IZnGqXiaFgHUUDkrALdPn8dJkdDtvl174YHgOQSiAaMWrUu35/R
         RIMVBxasx60/1uReeA1zJMxGvNmzXdVPH4BpVRxo6KxlDbOAhcW5r29SM39BFZRN36kA
         wNWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Thu, 3 May 2018 14:21:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, hch@lst.de, linux@armlinux.org.uk,
	gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
	bhelgaas@google.com, zajec5@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, dan.j.williams@intel.com,
	vinod.koul@intel.com, thierry.reding@gmail.com, robh+dt@kernel.org,
	frowand.list@gmail.com, jarkko.sakkinen@linux.intel.com,
	rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com,
	johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, bharat.bhushan@nxp.com,
	leoyang.li@nxp.com
Subject: Re: [PATCH v4 1/2] dma-mapping: move dma configuration to bus
	infrastructure
Message-ID: <20180503122133.GA18590@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1599445329683879120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This still fails to apply against either 4.17-rc3 or current Linus
master for me.  Please resend against it, and mention the tree it
is against.

Also please resend it in a separate email thread (all your patches
were replies to the previous ones) and include a cover letter.

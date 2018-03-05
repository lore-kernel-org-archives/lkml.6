Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AG47ELs3lULQWU9D0vEIPD5sqaVaS0qpEZacQFU1Mqg/LmQDszR7RYSJE1/xZBtxvxZAL9FINAa+
ARC-Seal: i=1; a=rsa-sha256; t=1520262494; cv=none;
        d=google.com; s=arc-20160816;
        b=LbUUabsQ4vUo2RpRHm6aWkn1ttExwOESp/qhU4z2c2SdGpisEnSkroMjue3pSE4NfS
         GG+vn695Pjw+CK41jSbjld9w02DiLPY1tQwmG5I1UMsDnfqOVulMgg8m43/eJ2tQT0FP
         J2nBa6IdArz61Tw85Q0ab8YVyUY3yd5b2dzdDSFjbKOYTrcqH2rMt4g102bmaJrkcPrm
         mfN0A13ri/Vv0Ko2SQN1BA6NBmXGqVEpxys8AwuPCtYqVGGVjz7vAKF0TMCxbvos/QmL
         /dhKwuxCAsrM5KAK9SsgJ0q2nItkhDmQcAN2llZTzVDHE3jvRbiD+NmLRaycPQbzN5sz
         8KqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=G+S9s97gHM0X8InHPqFP7tvPiNGT6EmVFbdvUZlSJIw=;
        b=lcgCh3ivCAT+kzykcJ2WEnI58FpDj+eO/1zLcy+cD69sBh7yuGOsFd+lCUJwsMnnLs
         Igu94oqYc8VMe0F4PtZRvjMr96aHCzUnxRmsXIBxlvzpbYFRxuvAmcklPEPnURRBBZV4
         VYXiqARJ2sEHyyBGAGr2bzgI02BHzqrU32XSYagJ9jqJn8OCrhsCKD0S1caLFexjrtHr
         jTMOsMA61EIRlFVzQyMfw1GiNG/bqFhButq3jCW1WbGROeqXhtcqahMWCpyIzIjyGHRy
         X4hRG22tRJ01GjQd0KlNBbe0qPRTaH6v7ncLt+C26Gpo6K8vxDfLHEyx5T2H44O1KKbF
         IqJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Mon, 5 Mar 2018 16:08:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: will.deacon@arm.com, robin.murphy@arm.com, mark.rutland@arm.com,
	catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
	robh+dt@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
	gregkh@linuxfoundation.org, joro@8bytes.org, leoyang.li@nxp.com,
	shawnguo@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, bharat.bhushan@nxp.com,
	stuyoder@gmail.com, laurentiu.tudor@nxp.com
Subject: Re: [PATCH 5/6] dma-mapping: support fsl-mc bus
Message-ID: <20180305150814.GA15918@lst.de>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com> <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108392554438818?=
X-GMAIL-MSGID: =?utf-8?q?1594110765351289678?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We should not add any new hardocded busses here.  Please mark them in
OF/ACPI.

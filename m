Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AIpwx4/ehnd0D8bG+DPRDajkeEX/gjTCOOr1oTjk8yTcP2091rcnQJ9c2mIUpoR2UXok1ndwA/kN
ARC-Seal: i=1; a=rsa-sha256; t=1524488135; cv=none;
        d=google.com; s=arc-20160816;
        b=QSijUIdws/XINDRKrZnxWr4nTYUN9xc6/mp+WI/yUaWlXwkO7yuQBtxrGKaMI8cP3T
         Lsau8nCQ6bldHrSrkl1aZXuDDAn2OpBpmtQLvGlWbKzDDiHvNMAAPJ0ELQitBYRBWEd7
         +5SPwpkbE2+6kfrpHOd2bRgvwp8b8mtE6ZRYrcwTpXZYWTCymurktL0DqOU3zXrb2zeA
         W/8Q6rF+9N+8mqd+j1B2niE8gdJR1W7SGUHZs/DEBnUPFxZlYdDuKiOv6n1POw7BVUYb
         /oMxni6WMlQ76ZnlYFMpLJ8sULgup6On6iS1cljJ307WpnRHHS7ziUKUs1D410mYqonz
         sTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=BKOWftL2l/u5b3c3n9AXa20cu/xrGLWhmy0KK2Nva9g=;
        b=JPCWvXUzKTBNsmJNimCdVLySIOish35GUkrlsgsYNu1Eys7DCYJJ9XoqHwrEE+Jc8H
         6WLPrEOIOh4KVGX9jZWRgH09Qd5DGzem1wfQUbyndVaCdsFGzFCpmLYa+SCnQtFv4dez
         t/ewoOqQECnhpGphLaY6t7k9rFq42z0PfenTGLcQ4Hl1z6xeuvu5ZOO6roNqJVL+68kD
         BhiqefoyNmKbN2urCbFiXbTMwolnY7rwEXxicfdN5mLc412GQTDWkgPnfrz3GBQJ+aDA
         v28d/MWt9FFrJCreZ0cbNfGFbEfcHQbitaUjnHNg3+v7FxmvZnkA4s1UbFHvPXFoAODw
         222g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Mon, 23 Apr 2018 14:56:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nipun Gupta <nipun.gupta@nxp.com>, robin.murphy@arm.com, hch@lst.de,
	linux@armlinux.org.uk, gregkh@linuxfoundation.org,
	m.szyprowski@samsung.com, bhelgaas@google.com, zajec5@gmail.com,
	andy.gross@linaro.org, david.brown@linaro.org,
	dan.j.williams@intel.com, vinod.koul@intel.com,
	thierry.reding@gmail.com, robh+dt@kernel.org,
	frowand.list@gmail.com, jarkko.sakkinen@linux.intel.com,
	rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com,
	johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, bharat.bhushan@nxp.com,
	leoyang.li@nxp.com
Subject: Re: [PATCH v3 1/2] dma-mapping: move dma configuration to bus
	infrastructure
Message-ID: <20180423125657.GC8824@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <1522396485-10248-1-git-send-email-nipun.gupta@nxp.com> <20180410192041.GA54986@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410192041.GA54986@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1598541671198634223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 02:20:41PM -0500, Bjorn Helgaas wrote:
> I assume you'll merge this via some non-PCI tree.  Let me know if you
> need anything else from me.

I'll take it through the dma-mapping tree, so you should be fine.

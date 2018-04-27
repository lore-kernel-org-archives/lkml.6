Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AB8JxZpM998chwPT+EbvFllvPqVmAOtzmSRgsn2kutBQ3K7wGUd0OSa2Jz3v4ohWhCRrn/knfHP/
ARC-Seal: i=1; a=rsa-sha256; t=1524844208; cv=none;
        d=google.com; s=arc-20160816;
        b=bnMt7vfM8hCL0NUDkk98yaJ/17aj2vt4XX6I4CHkO+oDA7vQDC9oyB7OPTtDQhrf1q
         wI7kupe0P+N2jL4eINxLKZQSAMXf34zM6T5otYDz6X1Jti7T48S2ec9pUvCf6Q7Zbc6I
         pfTPItr68rYPuSWjiPfRDmnZrqrUQwlB/DUA0Dveob0+zOrSKrDZGJvhyDhY+TAbVmAV
         GxYp9Y+myXjwibRA9r6R58+9kO78VP0NIzFtfeCuxNJMadskFoZQJMpCqsdY1SQlbfvr
         nFhIe4KRc2y4noKVpHcOwzC9lx31EMEcMenPlZHazi5viB/ASDsRauvhD3+54Hnh/usO
         ZG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=GDsyv5VajiS+nGlW9/2s9dQNoMbGUm72ELuV4G+v1iE=;
        b=oUC4+EuWTWGAg47kwDhFmxkTADmJZC/bjWkW7N0MC37DUzxtZkV77RgYqLfokAASaT
         ZuazYYOLEtvk83y6jZYYdzP6SP/SARta4WyQI/e8WsIBsQci2wm6NNk42ykcvV96ynBF
         Yp83HKn1UiIOfSTygclBNIRyD+XXbk1cdgwtLevoQudNBi36JBq7ooy2eNHM/iXp8+1h
         6RwTRgc3M1VlUppH2hKEVNuWTmbHraGwluHmdS+QdnBQ2vvwUXpAGqXdLW+m+sNNtz4Y
         jOJuey/6SSLWqtrj4mqbsbaVblA+rjqXUynov+wfVbiK1R80QiO2K96e+gk2PAxnP2xE
         fKgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Fri, 27 Apr 2018 17:52:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
	catalin.marinas@arm.com, hch@lst.de, gregkh@linuxfoundation.org,
	joro@8bytes.org, robh+dt@kernel.org, m.szyprowski@samsung.com,
	shawnguo@kernel.org, frowand.list@gmail.com, bhelgaas@google.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
	leoyang.li@nxp.com
Subject: Re: [PATCH 0/6 v3] Support for fsl-mc bus and its devices in SMMU
Message-ID: <20180427155203.GA9201@lst.de>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894760308217340?=
X-GMAIL-MSGID: =?utf-8?q?1598915041040892594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 03:57:00PM +0530, Nipun Gupta wrote:
> This patchset defines IOMMU DT binding for fsl-mc bus and adds
> support in SMMU for fsl-mc bus.
> 
> This patch series is dependent on patset:
> https://patchwork.kernel.org/patch/10317337/

Which still needs to be resent against 4.17-rc..

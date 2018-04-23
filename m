Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AIpwx49hD3/c+B0bv4NDqdq6Xq3/aW6iQ3SuQpHYcVtiJLMN4zo8RPkXgLAsu89efneW7VMX27c1
ARC-Seal: i=1; a=rsa-sha256; t=1524488116; cv=none;
        d=google.com; s=arc-20160816;
        b=JSvYzMYXoKYyu4mGrQK/N2qv/bn2Ci5rgaiypjy2P14RSiVj2by3qTi3mZ787a1on3
         0OuaddgBsX6jWgtNYgNhAf0OzYBwcirOUNwjUd/Up+mwxh6yYNzvUfBCqBSmNYyHCPzk
         1L4OjlOgogxFzZJhDjn4bgHTqJ1ucDUMYkr5lKvwFmP1h3Vuo8K6BetsPONbwpGGTFTS
         TsgSo7TuIDDH8Y3j2ZuzRf4vJL1eOAfNeM6yFg1vZ/Y2D1yGl4qw0WVarsMMbJ002YtX
         7FiwF+I+rLDaia9rdqUP3Pt2EH44LFZ9BheESvZXfg0RbQhMPoIxPeUOSZpje2+jkCZE
         n99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=DsSdiyQY4GRenRYWEpLAr2B0gl0hOelE0qwjHwa7AjU=;
        b=Qn7OuQnDNnnt/Jc1ii4QzNQdKZHbFMo3xeWKI62u4FqCZ9xRM5KYhcsG6N99XMZDIH
         JkxflcT9nfkoanDCCq60vqAs5QIn04sX8g6ohVrXCmoyv8E9DF9N3fGgpZLz9h+5vRFk
         AhiAcrYxdJs+W5L0ZLaEkPwkK9V7pe7sAIqQ2yzDHgc9ZNqAr26L+zCdyBLdZvp0g89g
         i8SPBK8XuLxBuEoBf07lf0cZYvpV+IJkfDRcLnDl7WGYX+C9CH4Z+VNZYAwWt9YcbhHz
         gmi/JIelsu9HBkB971Voog9vZbUUouOa3hII1JTflIMUIB+P3+Z960tYpTYfskDeYDS7
         CXlg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Mon, 23 Apr 2018 14:56:38 +0200
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
Subject: Re: [PATCH v3 1/2] dma-mapping: move dma configuration to bus
	infrastructure
Message-ID: <20180423125638.GB8824@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <1522396485-10248-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522396485-10248-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1598541651004098280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Can you resend your changes against Linux 4.17-rc2?  There are a lot
of conflicts as-is.

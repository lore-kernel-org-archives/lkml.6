Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AIpwx4+zwU2Qa4lZ7DZ9t65GozCYJ747UyTwxsOdveoKrF5m8th9u8Oiqk9bSAM0t/W98h0qPv+U
ARC-Seal: i=1; a=rsa-sha256; t=1522394131; cv=none;
        d=google.com; s=arc-20160816;
        b=byHhn2LH4kiQS7Vqd1O5hTWA4l8FXcM7ppCRwK+iL5zofjq9XPyPj/hrImn6Hofsoj
         LHcyK+hi9a6TtJ8YyLM4vVtWbXE19guVujAyfdbfd/RocgQrpuur6alAJEXLuVsPspTX
         iDOGWlHX2/J6x9NLkl73RO7UDTElF5UzOHFMiO+3BwPz+oKbKaqWhm4vPe1F4EOWsNNB
         ysKhuTitrkQOzStOvBSyW9YSj+4RQpkukoL1UZu30Z4h6yvPfJF8nktujbA/jVmyluKA
         hyi3gW34AeQkuRZ6FGXb51mgobiunL8JkB//5QDcpY8ZA0g7x5KAj3ClToyTMic8G1VP
         wC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=TB2du0Og9+fnHgPuOhOK+cV4uu1TQTT2TKpp4OujAOQ=;
        b=ds3ezVdTyEm2GXl2LDkqPcvxOfmkxKYg7cj3KJi1bPAz7idwOCYLWqYM3i79L6c5DD
         g4LJAgPTTvZZ5PjXh3zm/OiMA9+vXN9vCSLDolu9L5OWzZb0lmBH0n8v03yr3AYbrshK
         n3AavwOy17IqRzRSaa8tHnAm43twziB15zoG55fJTthQUr/fi3kdmSn0pVkFpVMLji6Q
         CBKUOqQEVKE7MHvwhHwmpBo0GjBgACkELVSZnbwvNOZgyX2xMPnGr05SOdrI4p7XvF0c
         b8JzNRNoV7H7ysM9Vf3NNgt/CPmigTIWdNgWJ6ea97Baa4pG7P88PwdLFhvo/oJl/x4U
         p4qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Fri, 30 Mar 2018 09:15:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: hch@lst.de, robin.murphy@arm.com, linux@armlinux.org.uk,
	gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
	bhelgaas@google.com, dmitry.torokhov@gmail.com,
	rafael.j.wysocki@intel.com, jarkko.sakkinen@linux.intel.com,
	linus.walleij@linaro.org, johan@kernel.org, msuchanek@suse.de,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus
	infrastructure
Message-ID: <20180330071530.GA17557@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1596345948552213336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Can you resend the current state of affairs so we can get it in for
4.17?

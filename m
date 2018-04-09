Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AIpwx4+Yxy/K6QYTEDB7XDc5NgZVjbbMGcd18sTZt8BbppAxUl7s1AQye3wLl+BqWkdKbsjxa7+U
ARC-Seal: i=1; a=rsa-sha256; t=1523315558; cv=none;
        d=google.com; s=arc-20160816;
        b=CdqytY/jNCnMJrkN7GFqEveVZCdCym4+V4hxYoDujug3sRqwWmqS0W3BdvKgAA/Wcy
         RL8jdPzw6tQHC1E6wfFhenCzdUNfUNUWIkkas6Ecd3S7ZZ6WtO5N1DhohHFuOfOQzBuL
         WgElthuTNN1TFG4YSPQ6aaEbhb59O4hRB3p9YBcfQ8D6alPrHV5wywPALr88OdoL29UP
         AkiZQVM+o4AVGlgsY2bVT0A000NiU8Z5b0nvqrN0jLLgxKB66DQSK9cqVOVhLBe4CiZ0
         Bw8M2PVIdAuqLZi8fDpIGjn+PtkHmBYrtP3epnQ+mAZMAYSh523Y9Ob3M/rpOOlectaa
         W4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=88RdRCju7sj2tt4yxG/GZyTrvLzPsmbJd2EQAXoW9So=;
        b=Y4sUnCzPB+19WGf3eYy0isyqEHP72qQzpUQ5J+edMbWAS5EeZyVsYqdrqhhfIXdb9D
         qU71ZZ4DCprzuQNaAjQp9DPqHB6ZJyAfowKesSmBNCbYFe3CQ6XoZ/dPmw+IffJglEYZ
         44TPorCJEZFCqGw7TFHSGSRpAFvj4EFLwnokkXMNuAWGoTiiqjwxHqrNmiTr3uaAhv4Z
         5Fhq+bJY9geVcNoJOvGV41Uf8LXGPC3VZc2eWgOrkXFbomrli0/dZ7Cehuu92ABxbDaX
         vve0tCB9WjTqdbUfstPDQb6s52mlAStH2LW5A3x5l+F7zl8/7sGMqd6UNQdXE9bmTl2o
         27xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,429,1517904000";
   d="scan'208";a="32079607"
Date: Mon, 9 Apr 2018 17:15:28 -0600
From: Keith Busch <keith.busch@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v13 3/6] PCI/PORTDRV: Implement generic find service
Message-ID: <20180409231528.GD6283@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-4-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284914-2037-4-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280026938486684?=
X-GMAIL-MSGID: =?utf-8?q?1597312135236862745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:51AM -0400, Oza Pawandeep wrote:
> This patch implements generic pcie_port_find_service() routine.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>

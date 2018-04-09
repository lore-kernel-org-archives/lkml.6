Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AIpwx4/PuQGlfnRtohvtqkF8lynOFyTxovAbdZJGZqmrE0Wsz+9xhg+ocNoqAyebrh/tRQnHNPUE
ARC-Seal: i=1; a=rsa-sha256; t=1523315540; cv=none;
        d=google.com; s=arc-20160816;
        b=YLFfACr6ZrGMho2gk/pbO1quvAIkYAmHuar7L57lOkwdya6YJna0WInGpMT+iaLX1h
         NObajjFupOFIEp7IL6DIj31HFXndaP9ujVuDbS5d1s0tzt3p3Eu3zOrw1fV2PfMW393j
         X8ezT50BiFyWytgFwXd8vgU+NOppJUMrHFMTy+JT+BhwHOBzP/lnXLkNz3rIzBkXenj8
         xwhnZHuco1IGSfNBgWhpxZdu3Asxe+RzILvNeOIwrqfajep06qITHuNnJ91MyjVMjeFp
         kc3tKWdf1WnxBxdreP8jsaEhh/nIx6pFwVONUgqNFxtcscto0JHtJGvuu324k3ex2jiy
         K6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=9VvIjY66ow7sU9Zi2yDSt8n97io/GVHppuRShkY69rE=;
        b=xYCe682Avmk9dd3HREAKpQjzepUtypVhqGpkCnWDgGAJz8cjtzul1iEREYRYnC2Q+l
         lAl84fz7vkEhtG/4BPhS7m4eJKnTeiRHXKrD6btXaML/Yl+pG1kGjHG/605QYIQHdMD9
         zdIE1CzqMo4rwoqIl2uvqAZ1KFGB9B8VwZhFRjqgzIt4MJaAYc1GOucddGnVDv4co4qa
         h+tY0Qld6/E4PQ1/4f8nAgzNozLdyaWRZut+QDQhR4fSq7n+gm0VynxBLiV6zIRZuxeP
         g9xfTrdnfTgV3bEKiT8MoekwDpia5KIOpktQMLNP8+HIXupw7tj9j7VyBNEVNp7jMYHq
         OTtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,429,1517904000";
   d="scan'208";a="32377352"
Date: Mon, 9 Apr 2018 17:15:09 -0600
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
Subject: Re: [PATCH v13 2/6] PCI/AER: Factor out error reporting from AER
Message-ID: <20180409231509.GC6283@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-3-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284914-2037-3-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027806838583?=
X-GMAIL-MSGID: =?utf-8?q?1597312115641062077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:50AM -0400, Oza Pawandeep wrote:
> This patch factors out error reporting callbacks, which are currently
> tightly coupled with AER.
> 
> DPC should be able to register callbacks and attempt recovery when DPC
> trigger event occurs.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

Looks fine.

Reviewed-by: Keith Busch <keith.busch@intel.com>

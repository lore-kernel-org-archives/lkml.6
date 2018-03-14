Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AG47ELs1lr79VryDh2x36FtsgXGv50svOr4x07JbcsZ4vXkcud5scMWBTjeBSi/30ZLM2BbRuoYH
ARC-Seal: i=1; a=rsa-sha256; t=1521060856; cv=none;
        d=google.com; s=arc-20160816;
        b=lLYOK6yf38IExxPPbezMQCiMwbR44n7OCFCwArN+aEgQtJ0WXQtxtGp4Y2G3dNsKIZ
         envxXEpe/wgDHaVVoaYQ7XUG/i6Fxz7uwJ8wOYzVzIaJ8piMWnbLGHFP+Ec3xIWS+ovT
         chZ7T/YGIwEEKdPfL4gkw7cC939szAOph74QkHme5fLfeTTqMpYGrcUEP7e/Y22zZOiV
         seSVJg9JXQ2XTEgWh6wdwDg7AStK0bAQqJ27VKG68FB9QWR42RXJCjXYeGDzUYbRu8qk
         aa80+7fY6b1D6W1XN5bZmdZZd6qNi0ezeLok9/pgLr2zGPTStrIY/yoYrvnicRiNJw0l
         Yx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=StqXd5xps3nwpy/M0jdTRbnRtJIFaroAIAcPfhQ86aQ=;
        b=cQHW/1dfBYCtqIt6xkSo0YKx7eJeGwmgyrOyM3gGnP0ohoCSGXDcDW3l5aMllmSitl
         Hz0Mdr7PgMmitKj/Bu3cUUdBnTZJHyuHLVnLLk+cf4N495DhM2gLYyK+0A+/XGoq5VvZ
         sw9Va4igGhew4phMyyv8K0geRFo4yLku4LCOxVSgC43/0/DWsZWbE4gysA+SYwDXBPeP
         PS8hZ8lsEKv8xJLa/kW4WXMQyzFardutNh+UQDDbDfPBQZOXgU2Mh4k3yTaNnYx6025G
         Iah6uRazqCW1PdBAxdD0TE9y4u/u9OnSmOagXj9sw6MEwSrgye4oVauzB/Rfk7rcdedX
         MkmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,307,1517904000";
   d="scan'208";a="25741833"
Date: Wed, 14 Mar 2018 14:56:15 -0600
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
Subject: Re: [PATCH v2] PCI/DPC: Fix PCI legacy interrupt acknowledgement
Message-ID: <20180314205614.GA30695@localhost.localdomain>
References: <1521042648-20522-1-git-send-email-poza@codeaurora.org>
 <20180314205230.GF29867@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314205230.GF29867@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928862601446730?=
X-GMAIL-MSGID: =?utf-8?q?1594947908936630674?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 02:52:30PM -0600, Keith Busch wrote:
> 
> Reviewed-by: Keith Busch <keith

Whoops, I accidentally truncated my message. My correct tag:

Reviewed-by: Keith Busch <keith.busch@intel.com>

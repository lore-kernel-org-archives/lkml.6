Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AIpwx49hadGT8GR3QenFMM1j1K7ZtTHeHkiH1+FFEdh/4nuciwFF/Ej6ZakgKsDlPvBN5CbJ9gVp
ARC-Seal: i=1; a=rsa-sha256; t=1523315519; cv=none;
        d=google.com; s=arc-20160816;
        b=WKuyfWDot2e8SB15+FHqSjS5VYS98ejOGb2te0pxEQ7IIzZbvhEk+dUffw943tM9OD
         Bc20wTVpKHT/MejfmGtYUpVAXC7ekgYHW5yMR/sQ1ukbkEY5jRRY5/RQ09YS4lPIpJrt
         2v05UI7iUTppFH9vqi2RmvITYofrLMdsgVDzWngJ8/OThiXMHQKhtUqh9ssmRnwLueha
         fT7Q4nwCvQcDBm5xJDLIhMpI1nl3Ib8Z2bcRhZopaT2Ej1ngPM2oyuae1I0VlxSCDhay
         LxIUbS8W1yZqYOOzLK+B6OpoOPiiw89ChKf5Oy5NpYi0aQRr4kQG4oBiswVEJnTKl5P3
         nQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Hm01vfXWYOn9HmZ3D7ahugpprWfhKjbCsO0bOy1GqtE=;
        b=m06ZRlKc14qOMhbEJ3JT7rTuOSsnbTHpHpsAZU+fsPi4Z3A4zQNAlglxyH/dmBawZv
         Zb9guS3iI9akAv9rQvnppqnOsdw8/LxpUuMZPywY3paQcuKhln/8WjeSmhWks+kgvIlZ
         UIXcnWs3slcHC3lBgGrJVJ9tUJ2Ge5fFku7X6THAWFPRCMtAjRInS5LsbbQLdQoYsic5
         jT9TUXDeVp6OoyJtq/MYKiqSTXEEku7bA0c+LcICs9rVBeB63WXQdNBeRDUiOxGjUve1
         VnGqNPjOdSSiGDEI6XtXx3tKQA/HYhB2roQjT8nqRL8aLkTCWOF9yTpH5JAMjlqMdeH/
         NS3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,429,1517904000";
   d="scan'208";a="32970181"
Date: Mon, 9 Apr 2018 17:14:48 -0600
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
Subject: Re: [PATCH v13 1/6] PCI/AER: Rename error recovery to generic PCI
 naming
Message-ID: <20180409231448.GB6283@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-2-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284914-2037-2-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027496340053?=
X-GMAIL-MSGID: =?utf-8?q?1597312094382861144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:49AM -0400, Oza Pawandeep wrote:
> This patch renames error recovery to generic name with pcie prefix
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

Looks fine.

Reviewed-by: Keith Busch <keith.busch@intel.com>

Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZpR99sOVPshiXS5MnPQSV80wwG9prI0HbsYF6UaFZ1+y4Y67Z32HZ26tgSyclXqdr5YZH2R
ARC-Seal: i=1; a=rsa-sha256; t=1526322438; cv=none;
        d=google.com; s=arc-20160816;
        b=qoSli8bt6GB9eca9oElUeWzQjBXSYxqcrAmWbUqYvOB5VtFSk+QKBN1zVjBhNTLFVu
         WK8T0l8db/KCM+K6p1uVk/e3i/qVqdFUQ7Snx10p5EvS53M/nrGubF/ZJWJU9gcLruj1
         OHt3e5vaUOKcAbrSfC8eMs+PiH6sapIL7OS3uufgadYUMjntpCFJGiq8sH0kVGveqm0I
         AQAiknvh2XJ2eD7qjS8VfG6EFMz38KXj5lyZ11+veTMChfk/mv51Qmg/Ntp51+lTXUDw
         NYhUBdP9FKHh6h/oTln3pqE/YNFN4G2SEIQqwQKN61faiLSWb2PLse974UcAee7w0TC0
         Houw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=vIgobCDVP+/oSYi/b3M+mTjR85NvnD+uQ1yWOzpPaIw=;
        b=pRiEjsUTVTZtxPAr7DKIDR/gGdsp9lZiMaXzmVmsA7dBU72csywir8L62V/lSfbTUL
         bNTDw5yWUqyX+itGj5tex7y7YwXHt1zHL+uCNefimqfucy08sj5yYbuxD3ULu7+ptfHM
         ZB2HSULa7Vt3d9wfBvFA7t7SfT+qdRVIiAKv3zKTtYKhTS2vfoV5c8HJJyzPWVWyhua1
         enegkXOCONtc8/fNGDEKONt0h6o3vKT9oBrTqhwHag0Wb8NWW2jcy2Oe4RMeYdeK0ZB3
         vLWJGbEbs/d6JEh8o0yACJN6yIV2hArRUs+Xnsd+mMg0UnzdPbEmSkBeLgK1xgPusKKj
         QP6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="50763571"
Date: Mon, 14 May 2018 11:30:04 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Wysocki, Rafael J"
 <rafael.j.wysocki@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Alex
 Williamson <alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>,
 "Christoph Hellwig" <hch@infradead.org>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 17/22] iommu/intel-svm: report device page request
Message-ID: <20180514113004.2bb24549@jacob-builder>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BEFA7F@SHSMSX104.ccr.corp.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1521774734-48433-18-git-send-email-jacob.jun.pan@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439BEFA7F@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696334534344100?=
X-GMAIL-MSGID: =?utf-8?q?1600465077525300087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 14 May 2018 06:56:11 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> Same comment with the one to patch 16, pci_get_bus_and_slot() is
> deprecated, may update accordingly.

yes, it has been updated in v5, could you review v5?

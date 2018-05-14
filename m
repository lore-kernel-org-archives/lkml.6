Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqlv/0kE8IkZHaCpiT4e1eUl5WJ7aOT0kx2FUysrn0YN+BvscYr17QNSXkucuPgLsbxnk0v
ARC-Seal: i=1; a=rsa-sha256; t=1526323703; cv=none;
        d=google.com; s=arc-20160816;
        b=MCPku9XWSgEajaiwsG7/wAYOTfCQ+tlbyFROdr/XQPjnNfJZNF1woJ1ef/FvQTliJp
         ATKZbIo7WdNc1irD5q4X4m81rabYrQd8a8s+PVCw2LyHGIw5Fx6EoCiO3FDmzzMRoIL9
         C5O30xDdCqXojCoI/JbSGzUWYmNI13cA4uFszWhk+J7XQK64Z/hQ1hu536Q8QxeMSTR5
         Qb94Igxf5pS5rdsaUyjYv/NJGqgfNaIwIEf1UiqNDxz+nA86NjFzCRfSX2HBtxLeRNbx
         Bw8ag3moXP3dT7iwKk2sx1d1/8DGwrexasMc+IwzePLO2gaXTJFKEXgH8tVVOtDcbu8p
         3q8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=6znIM142goUyowJhUNz1GfTOdHEUA7sYq76jbGGo/yo=;
        b=jC7mPvbAif8V6L4BJYIhtN7kZXhs3PJiCgAQ1WfMvhl4xf2CON1elluogkMqF20bhk
         WAwUTU9xkEVfKyG7aU56JRgBmByjPIxtzvvXD10F+UvwZQ1usapQNklEgBMR3ftumUyg
         X+NBflBVO3K1gdr41/oXFRRB6shJJEVeyq8hT7poH28e/chP9dSAjpi3kdFnp7DcJeGb
         NRYGe0pVk4cuUzZFDUr3ZWPOzrfrrqlFrlRv58CkGjUgMV9DS5XfC/L5JrL4jueaJcpR
         Z78I7pHzBcmr1uLYtRo+urFRjHKFAQNz7iUGSz3I9aTNk/Hl6Tb5MLvTqZ9XBzX93f7k
         Oyww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="55824233"
Date: Mon, 14 May 2018 11:51:09 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Rafael Wysocki
 <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean
 Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 03/23] iommu/vt-d: add a flag for pasid table bound
 status
Message-ID: <20180514115109.6cc887df@jacob-builder>
In-Reply-To: <5AF7EA43.5060805@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF7EA43.5060805@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202361739379214?=
X-GMAIL-MSGID: =?utf-8?q?1600466404253582323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 13 May 2018 15:33:23 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 05/12/2018 04:53 AM, Jacob Pan wrote:
> > Adding a flag in device domain into to track whether a guest or  
> typo:                                       ^^info
> 
good catch, will fix. thanks
> Best regards,
> Lu Baolu
> 
>  [...]  
> 

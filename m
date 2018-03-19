Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AG47ELvoYmRD4pgHL7xZwMohBrAb8B0IW1aWPkGO7G23+zkxlCYKNxeRabJ8V02KeWdzvHknBfQG
ARC-Seal: i=1; a=rsa-sha256; t=1521455475; cv=none;
        d=google.com; s=arc-20160816;
        b=ZY8mIhJc1QTR9cLlYd8Q04vjAnsX30FDhk7Lrecl25wzRn2UqIphbqnPNiaH8mcO6P
         8YT+SjHa8uLaQCeGdF0DPO8EKq2Tk8PDvodgRsyjO7CPRDcXsQ0RwUUbx6oyRB/Pfrgw
         ltwy1+LWCZEmWf3pO82fIqZSs9xAiJD4IFvAYsYKcZCDdmkFsNCaFDiup14UrG5vKzbY
         D77tClP6aZzoD58w61CA+m79wmOMu3NLgIO8ZLMoIWCNSqh6+VdKGRb+DIu2f4HTO2ET
         eHRkZNqsOsezAr2jbU7wQQHa5YqFohlcc7s4ZNUkn5OfACPnYjLCyWGGdmBEQsaZzfMs
         rf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=RHTP3z4jp6LQR+VRDRZVbkHLQ8RIkA2cyUIxNEV+8lk=;
        b=qT1b+osBUcZxwf/xvLAmzk0UxS2BVlKCu59BECztEhOPxUDN/omlYD1JeDbNzz2lkM
         vOn9GcvtF5t+bK5qtPqruk+/JXnT9Hbj0YOIrmq2AkZpRW3+6z+6zHI1oz77MK533Ujm
         O6Rq2AXVLm24Y5A3G+n/80XU+/HAAVUiEVeUtXJSlssXrVzqPcXi4hVLqLhgfJAZ071T
         a99LWN99einNS9Vp+z62G4GG/qpa/pZxC4bMuI4zmxPAryl82DGTtM6gFsOJSzc067dA
         +vIKAA2RIYJ1hbl8fVbb4hNnU/7w3g7jlX2qouvItvlB8qMCDiZBoKOi7607GM92Dqft
         qhDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, adurbin@chromium.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] ACPI: SPCR: Add support for AMD CT/SZ
Date: Mon, 19 Mar 2018 11:31:45 +0100
Message-ID: <2444014.2lujvRhnvI@aspire.rjw.lan>
In-Reply-To: <20180314214439.27806-3-djkurtz@chromium.org>
References: <20180314214439.27806-1-djkurtz@chromium.org> <20180314214439.27806-3-djkurtz@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594951095060046903?=
X-GMAIL-MSGID: =?utf-8?q?1595361696462197595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday, March 14, 2018 10:44:37 PM CET Daniel Kurtz wrote:
> AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a special
> earlycon setup handler to configure its input clock in order to compute
> baud rate divisor registers.
> Detect them by examining the OEMID field in the SPCR header, and pass
> then pass uart type amdcz to earlycon.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Can you possibly send the entire series again and CC all patches to linux-acpi
and fix the kbuild warnings if the are relevant for that matter?

Thanks!

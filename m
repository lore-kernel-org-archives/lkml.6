Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162639AbeBNTGB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:06:01 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:55572 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162470AbeBNTF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:05:59 -0500
X-Google-Smtp-Source: AH8x225WjGCqDphPee8F/4HKjdrRV8u62X2+hd/ZD4IaH0LqnS6jHQKpzbJJLC6xWf+nO7SUj/cjlg==
Message-ID: <1518635157.4749.50.camel@profitbricks.com>
Subject: Re: Read-protected UEFI variables
From: Benjamin Drung <benjamin.drung@profitbricks.com>
To: =?ISO-8859-1?Q?M=F4she?= van der Sterre <me@moshe.nl>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 14 Feb 2018 20:05:57 +0100
In-Reply-To: <e04b687f-30cd-c200-d08f-36b7dcc582a6@moshe.nl>
References: <1518612748.4749.29.camel@profitbricks.com>
         <CAKv+Gu_V7BCihPhZf=pKrkBZwFWeEoupamXvYSqdS+k93Gme=g@mail.gmail.com>
         <1518614486.4749.33.camel@profitbricks.com>
         <e04b687f-30cd-c200-d08f-36b7dcc582a6@moshe.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 14.02.2018, 19:18 +0100 schrieb Môshe van der Sterre:
> On 02/14/2018 02:21 PM, Benjamin Drung wrote:
> > If the UEFI is as secure as storing an unencrypted file on a hard
> > drive, I am satisfied. Or do you have a better idea where to store
> > the
> > SSH keys for a diskless system that boots via network?
> 
> I assume it would be best to use TPM for this (if your systems have
> TPM chips), it is designed for use-cases like this. Searching for
> "tpm ssh keys" gives a decent amount of results. Mostly targeted at
> user keys instead of server keys, so this might need some tinkering
> to get working.

I check our systems. They just have TPM headers, but no TPM chips
according to the user manual. The directory /sys/class/tpm/ is either
empty or not existing. Adding TPM chips to all servers is no too
expensive (to much man power required). So sadly, this is no option for
us.

-- 
Benjamin Drung
System Developer
Debian & Ubuntu Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Email: benjamin.drung@profitbricks.com
URL: https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Geschäftsführer: Achim Weiss, Matthias Steinberg

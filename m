Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeECQKx convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:10:53 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:39979 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeECQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:10:52 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Spectre V2: Eight new security holes in Intel processors
Date: Thu, 03 May 2018 18:10:44 +0200
Message-ID: <4378426.n3xRFAaMNP@merkaba>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

It seems there are eight new security holes alongside the Spectre/
Meltdown CPU design issues:

https://www.heise.de/security/meldung/Spectre-NG-Intel-Prozessoren-von-neuen-hochriskanten-Sicherheitsluecken-betroffen-4039302.html

(german language only, only found german language reports refering to 
the Heise c´t article so far, I did not find any other publically 
viewable source on this so far)

Short summary:

- eight new security issues found by various research teams (including 
Google Project Zero)

- GPZ may release one of them at 7th of May after 90 days embargo

- Intel considers four of them to be critical

- Article authors and editors at Heise consider one to be highly 
critical. They claim it makes it very easy to circumvent boundaries 
between different virtual machines or a virtual machine and hypervisor 
system. I got the impression that the article lacks a lot of details 
however. They even mention that they are not sharing them yet, in the 
hope patches will be there before the issues will be disclosed in full.


I did not see any patches regarding these new issues on LKML, but they 
may run under different names. Has the Linux kernel community been 
informed at all? Well hopefully at least kernel developers working at 
Intel are working on patches.

Thanks,
-- 
Martin

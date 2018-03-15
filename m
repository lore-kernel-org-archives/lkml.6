Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeCOUDX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:03:23 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54964 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCOUDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:03:22 -0400
X-Google-Smtp-Source: AG47ELv9DrTyrmScaVE1h54UZAizs20/Hx7KsJYJiszhdiSYXLtSqLKFNjnxO7AZBtphZZ0jn5rCJpRbVrVoTZYSLTA=
MIME-Version: 1.0
In-Reply-To: <17477AD6-0C60-40B4-AE86-56FD4AA6208F@infradead.org>
References: <20180315153934.3844276-1-arnd@arndb.de> <17477AD6-0C60-40B4-AE86-56FD4AA6208F@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 21:03:19 +0100
X-Google-Sender-Auth: eUcYrlw2V0Iqvv93SWIfeWCsIrA
Message-ID: <CAK8P3a1NwqyU+DRe=TK9PCnZetbQkragayW4oufV-_eTd+wd+Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell: avoid link error with modular ACPI_SMI
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 7:36 PM,  <dvhart@infradead.org> wrote:
>
>
> On March 15, 2018 8:39:07 AM PDT, Arnd Bergmann <arnd@arndb.de> wrote:
>>The new DELL_LAPTOP dependencies allowed one configuration that should
>>not
>>have been possible, with DELL_SMBIOS_WMI built-in, but ACPI_SMI as a
>>module:
>
>
> Hi Arnd, do you have the latest changes from me? The
> platform-drivers-x86-v4.16-7 PR to Linus yesterday has a fix for
> the ACPI_WMI dependency. Linus merged it yesterday.

I wrote my patch based on yesterday's linux-next, which didn't
have the fix. Today's version has it, and looks good.

My approach was slightly different from yours, so I didn't
get a conflict when rebasing, but either one is sufficient.

     Arnd

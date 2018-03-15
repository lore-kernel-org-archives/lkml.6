Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932478AbeCOSg4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:36:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbeCOSgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:36:55 -0400
Date: Thu, 15 Mar 2018 11:36:49 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180315153934.3844276-1-arnd@arndb.de>
References: <20180315153934.3844276-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] platform/x86: dell: avoid link error with modular ACPI_SMI
To: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@infradead.org>
CC: Mario Limonciello <mario.limonciello@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
From: dvhart@infradead.org
Message-ID: <17477AD6-0C60-40B4-AE86-56FD4AA6208F@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FIb1Rm002965



On March 15, 2018 8:39:07 AM PDT, Arnd Bergmann <arnd@arndb.de> wrote:
>The new DELL_LAPTOP dependencies allowed one configuration that should
>not
>have been possible, with DELL_SMBIOS_WMI built-in, but ACPI_SMI as a
>module:


Hi Arnd, do you have the latest changes from me? The platform-drivers-x86-v4.16-7 PR to Linus yesterday has a fix for the ACPI_WMI dependency. Linus merged it yesterday.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

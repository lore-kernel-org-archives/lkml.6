Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753710AbeBGJz1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:55:27 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35895 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbeBGJzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:55:25 -0500
X-Google-Smtp-Source: AH8x224GLrBG32lNHidVw+dsFeV8Xb0+mkKPOmGOQ8+r9vDv/ToT5rLyqSDDaE78Pox6/0r0n48KvA==
Date: Wed, 7 Feb 2018 10:55:22 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "andriy.shevchenko@linux.intel.com"
        <andriy.shevchenko@linux.intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "acelan.kao@canonical.com" <acelan.kao@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI
 driver
Message-ID: <20180207095522.qhs2wns4goif76u3@pali>
References: <20180131182614.19524-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VeFSuQYu67DdnJDjZDoaLZiPuo7ag7Lz0q6eSCDjayobw@mail.gmail.com>
 <2235169.mLvk2uMpgf@aspire.rjw.lan>
 <4289605.mKSTaFlacu@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4289605.mKSTaFlacu@aspire.rjw.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w179tVNg031797

On Wednesday 07 February 2018 10:47:57 Rafael J. Wysocki wrote:
> BTW, please CC patches with ACPI material to linux-acpi.  They are less likely
> to be overlooked by me then and the others on that list may have opinions on
> them too.

Maybe we can update MAINTAINERS file for acpi based platform-x86 drivers
to include linux-acpi list? Darren, Andy, any idea?

-- 
Pali Rohár
pali.rohar@gmail.com

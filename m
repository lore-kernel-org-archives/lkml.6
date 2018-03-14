Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeCNU3r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:29:47 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35924 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeCNU3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:29:45 -0400
X-Google-Smtp-Source: AG47ELtMo8QvWTok4xX+w/rM6ENiTDz4V6v64mntBKRfhQONOUwRKuDXDy+hJiu4F6qGaPRRp7OhzT+Uq1zgOI/kZl4=
MIME-Version: 1.0
In-Reply-To: <20180314194521.GA7096@localhost.localdomain>
References: <20180314194521.GA7096@localhost.localdomain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Mar 2018 13:29:44 -0700
X-Google-Sender-Auth: 1oN_mz04AsT2snHCZqoZ0lmARxY
Message-ID: <CA+55aFyN1uasjjsFOySpWDugipea_LhpE9_TSWR2avOYkTaanQ@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 4.16-7
To: Darren Hart <dvhart@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 12:45 PM, Darren Hart <dvhart@infradead.org> wrote:
>
> This addresses the Dell boot failure reported by Dominik as well as the
> missing ACPI_WMI related Kconfig dependency.

Boots and works (still) on my xps13.

             Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757452AbeBPI65 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:58:57 -0500
Received: from mail-ua0-f172.google.com ([209.85.217.172]:46445 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757437AbeBPI6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:58:54 -0500
X-Google-Smtp-Source: AH8x227KL6nFjBLlDJdaL2tLUJfpFKhZ2Yhkn2EEdKgJ8F/jv28KwIjMr8eDDCkHl1r9lSuUyKTnkZ+ILT2zLbbDYls=
MIME-Version: 1.0
In-Reply-To: <6e1f34ae-54d3-8daf-e531-976f36f3cb07@redhat.com>
References: <20180216082616.25084-1-carlo@caione.org> <da070fa2-9678-5a53-6984-2f200ac93862@redhat.com>
 <CAJZ5v0hLa5O18OPnX9zke9F0PMNdyy+3wgAvT4GXBJGaqngTzw@mail.gmail.com> <6e1f34ae-54d3-8daf-e531-976f36f3cb07@redhat.com>
From: Carlo Caione <carlo@endlessm.com>
Date: Fri, 16 Feb 2018 08:58:53 +0000
Message-ID: <CAL9uMOEJuH7hG5Sp2geECrnW_vcyqhYGsR3aCJFMdAfNAPVrRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] power: supply: Fix AXP288 fallback when not needed
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 8:52 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,

>> Well, to be honest, I very much prefer it when changes are made to one
>> driver at a time.
>
>
> I understand completely, Carlo can you do a v4 with the changes
> Rafael requested please? Feel free to keep my Reviewed-by for the v4.

No problem. Thank you both for the reviews.

Cheers,

-- 
Carlo Caione  |  +44.7384.69.16.04  |  Endless

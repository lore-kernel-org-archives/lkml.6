Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeDDH6U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:58:20 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:42487 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeDDH6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:58:19 -0400
X-Google-Smtp-Source: AIpwx4/PoZQh5B/rWhWhN34DS2dkezv7xkW7BQB4TVS3z9tbcBk8pFzKXXLOf7cgiuokvxcCCf4SKRkZZht/rYq2AnI=
MIME-Version: 1.0
In-Reply-To: <20180404075047.GB9342@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au> <20180404075047.GB9342@amd>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Apr 2018 09:58:17 +0200
X-Google-Sender-Auth: NCX2oi_5N3hwyuqXsbjqL_rPozc
Message-ID: <CAJZ5v0hxyXtyKacJufivL9HWbQBsxTBYVipnHK4+QquTYjpc+A@mail.gmail.com>
Subject: Re: x32 suspend failuer in Re: linux-next: Tree for Apr 4
To: Pavel Machek <pavel@ucw.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 9:50 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> Please do not add any v4.18 destined stuff to your linux-next included
>> trees until after v4.17-rc1 has been released.
>
> On thinkpad x60, suspend does not suspend at all with this -next
> version. Previous versions suspended/resumed fine but broke networking.
>
> Any ideas? I guess bisecting on next would not be easy?

Well, why would it be different from a bisect on any other git repo?

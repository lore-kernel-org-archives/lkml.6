Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeEVJSu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:18:50 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45280 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEVJSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:18:48 -0400
X-Google-Smtp-Source: AB8JxZq4cSyTi2Pdj5TOgN+laARz5EdQXGL9wNx5PBsLUnJdp3eq8AANxKoEqB//A/YgmzF0Qu3KETu3lg4/3hHz548=
MIME-Version: 1.0
In-Reply-To: <aa8608844b153359f5e2a7ab876c75eb19969fb7.camel@redhat.com>
References: <20180503030438.51150-1-chiu@endlessm.com> <CAHp75VfM+1HUi6W986r0iEiuS46TJc8XscO_ce4N-i66EtPLWA@mail.gmail.com>
 <CAD8Lp46edWAR2iVti8gGp+L_yy91ij6AHuJh3iuuTLg8oUq47g@mail.gmail.com>
 <CAD8Lp46-q8=t9RoWxLjZkv=EAJAbRvY37-ibUof+oVfZaOE0Kw@mail.gmail.com> <aa8608844b153359f5e2a7ab876c75eb19969fb7.camel@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 12:18:47 +0300
Message-ID: <CAHp75Vc4iXX7+VY3dE4ETjLsv=VCFaNwz6nmAUBS_E_dhpK2Aw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add keyboard backlight toggle support
To: Benjamin Berg <bberg@redhat.com>
Cc: Daniel Drake <drake@endlessm.com>, Chris Chiu <chiu@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 4:41 PM, Benjamin Berg <bberg@redhat.com> wrote:

> I had a quick chat with Bastien about this. The conclusion was that
> reusing the TOGGLE key may be problematic for gnome-settings-daemon.
> And the alternative of a new CYCLE key also has some caveats.
>
> The most straight forward solution is likely to simply handle the
> brightness change in the kernel and not report the key to userspace at
> all. This should work just fine and at least GNOME will show an on
> screen display in response to the brightness change.
>
> Do you think that approach would work well?

Am I right we are waiting for Daniel's answer?

Btw, I mistakenly thought that patch in the queue for-next, while it's
not. So, I'm going to drop it now.
Feel free to re-submit a new (better) version.

-- 
With Best Regards,
Andy Shevchenko

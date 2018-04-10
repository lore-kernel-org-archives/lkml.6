Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeDJS2s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:28:48 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53243 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbeDJS2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:28:46 -0400
Date: Tue, 10 Apr 2018 20:28:13 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, Jon Mason <jonmason@broadcom.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Message-ID: <8806871.109949.1523384893773@email.1und1.de>
In-Reply-To: <20180409230040.1100-1-eric@anholt.net>
References: <20180409230040.1100-1-eric@anholt.net>
Subject: Re: [PATCH 1/3] drm/vc4: Remove the need for the GPU-subsystem DT
 node.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:+Ni4vqGRATeWo/zO1CNwIHfGVUGn7SnUgd8l95ureQg20LO786a
 35TWB2A3y2ploFE2CaJnUtj7pOPgQ9BUUw4xIlYZKkoCebuISe6nalaZuqIZybEEZJZsQDG
 oLV8wczj0NHSgWxCUwHaRJesDPsnW4m7cYtbEJDeq8cp7ZzgD7XtqTW3ImhPAiqxtp0lHoK
 CbxmrvhF4iEuQzeq+ahAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:knRPB1+DPpU=:zcg5MFrGQjOMqVgfNgs9l+
 NNo4JWR83Ijw4UEw1QMUoxV25wrLhBpalIgKnYoFeQ1RytAvGviGgJqQ/xz2gmJmkz4qLJNI8
 VsYAdLQhutf3cSVZkl6UbYlTJI6esNkypE7XL8eCuox27Phmtisc3Kl7B7ytZCLcqEqlskNyg
 28bCGqIRxu+sDDvTGBLJc7mHymT0Ytyv1xDJxgItNsDnlVZpzIkt/GBEiNIcmMo0MnGjFljdc
 GzdZnhKq5lGKw0pNLCA5Akd3fqTSZ0JmnIn03B8vQ3yY1JrSYRgVZlo/KTSaV/gL5czSzqJhI
 n3uYzS6ToQ49x0CgvvALeCpvZAugGAlihM+KQtp0N6bs5sCSK6pXcuA603URCMCoQyZlG8IzQ
 HVUd5MqKKja2h+CohXKyjfODvygqhJ/tPIfVuEslhzNZjJ1Lr7Ndgw8E0FHsk2UJfw67/nq8h
 9RtodknLifkXuVWxvFJ3ZJ2UwkHeu1f4b0Mcla4n1/sXYXumOUPFS62LuWo+SyKmftZ5EFTN5
 UHmbZOU9U4uuWzvvKdqZUGrPxRCkP7zBlHdq0WEtOj+YhwAjF/1vLMc2ZzDlHd3YYLf23HziP
 WSGJXjV/fLXngMbjRoVlylGS4B074qSTykrvidv40pxQw3/Cdq/SNeLf9TXMBOEkGCuC6aTti
 vGHewDv5E3SGfetOMFVBDIAINzhWtorvNWyMhD+d9+K+wGwG0ImWGor2ugVHAv7sgDKBRdMLJ
 wW8iiEaTeA5StnI9OCk5Bfku/uAXpUfujUy2TvdYhZQ3JBevBX9WA1DnBIg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 10. April 2018 um 01:00 geschrieben:
> 
> 
> The GPU subsystem node was a workaround to have a central device to
> bind V3D and display to.  Following the lead of 246774d17fc0
> ("drm/etnaviv: remove the need for a gpu-subsystem DT node"), remove
> the subsystem node usage and just create a platform device for the DRM
> device to attach to if any of the subsystem devices are present.

i didn't test it. Does the code change keep the backward compatibility with older DT?

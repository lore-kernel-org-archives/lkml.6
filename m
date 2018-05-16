Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeEPHJe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:09:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:49535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751485AbeEPHJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:09:31 -0400
Date: Wed, 16 May 2018 16:09:15 +0900 (JST)
Message-Id: <20180516.160915.1252752723511457980.teika@gmx.com>
To: aaron.ma@canonical.com, dmitry.torokhov@gmail.com
Cc: benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Input: support for latest Lenovo thinkpads
 (series 80)
From: Teika Kazura <teika@gmx.com>
In-Reply-To: <ca40347e-44cd-aa93-75ba-1bf0a63705be@canonical.com>
References: <CAO-hwJJnHPEQ+R+8qWb1Dn+otqgmbcKgiNDOyNkVBD+xdzY_zw@mail.gmail.com>
        <00f701d3d627$bcf41de0$36dc59a0$@emc.com.tw>
        <ca40347e-44cd-aa93-75ba-1bf0a63705be@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:C38PHNBPB+rZylK3mcnLJGW5ADESiN1m/vqEMSxpfewnkwkKbUN
 bgxKKzvcx8wfT3Bt0LcCUqDnu0kF/Y/OpEBuc6TWZ6GeMq8w5cFzt2+1hwtrAUrXg/3CPYS
 ZVFLeLUgM8VV0PHrN+0X5q8DEK2gWDCADmeXruc5yl7IJf8aCfF/SdeMyIDt6FyD11pcza2
 8Ot6r4mhcaM6DrQYMmJpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mp7en1E2duk=:gxhfKEp2wQiRV2oo/t7kOk
 fAkczVmFUUJDq3QhOAYLQFNXuTAgBCvkZjWSpxw3orWC6eFEJypMserQxLmr2Fc+xUMFPJYXA
 tyoFkBmC+wdpi5yeGKhr2DOYyiKQvGd2pH71xX6A+2kS+2XEHf0zQzzXPCB68Oo6O0xdvO1VY
 ZyoPJRGWLTt9QzMh7qDgWrq7Xl2Ao38oW5YU9AmiBp/hrT2iGTFkrK4No154hmniiF2yjjx5R
 6QqwFFIDH2cxBO1cZc4Q/OmVYbD0E3gEbx226b5UfhbrRl7/fWHSfHFSdBOwdjWT6Qtw9UeNi
 dQGS1E1xO2rVfvOQWdlUyPdLpYYDLsHBvPIlWwikqF4JoAKZOaafkRez9Fr0/8baATPD8g8A0
 aJnaFzAzP5FYZUMdknx30B4v+fNAsssYOvzUKBJBdlhuRVZp6tWI/6GYs7LOiHk+R6Y3a2Lxl
 SxBRg67oa3KNKUYKoBFaJKx+vBHydMa4sK9HUp7PBrI00kaQnbuAWVY0+H3spFJ2TlNz5/SI9
 NjIv+KOnzEVXgE7oahQbL+UB6Q9BKJ1Mo8+1iVC6malzAG4HGYQqqO0YEFVP2klz83zk7WhYa
 okzbugbaQFZrFbNCRgaAxX/Y+CqM2Qxm/wnMKezYJmbWTlFT6atXp1rjjZLZy9fbMIAQPd2Jb
 OFMtkT9jGVNYr7K6mXcZ9Ko+7gh44B/TLhlwE3J445epJzyKSiCeOOaqLsJfYn0qUFg92fZF2
 uyixThdOqepyods4E5Sh4fUkh5KabiEIs3imh3LmIXR34/kDXIM5IJYO7V4ikIAkzZhwWhTFm
 ktdbham
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Ma <aaron.ma@canonical.com>
Date:   Tue, 17 Apr 2018 19:42:27 +0800

> Could you apply my patch too?
> 
> It add LEN0096 that Benjamin's patch doesn't include.
> 
> +	"LEN0096", /* X280 */

Aaron, in your original patch in last Oct [1], both *LEN0092 and* LEN0096 were aded. Which should be the case, both two, or only LEN0096?

[1] https://www.spinics.net/lists/kernel/msg2625450.html

Teika (Teika kazura)

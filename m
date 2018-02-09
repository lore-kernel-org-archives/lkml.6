Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbeBINvr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:51:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:42603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753614AbeBINvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:51:44 -0500
To: linux-kernel@vger.kernel.org
From: "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Subject: user_namespace: add aux data
Message-ID: <6f93a072-595d-4b18-b269-b9050af88151@gmx.de>
Date: Fri, 9 Feb 2018 14:51:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:OPkhs7UibSTW+AJ+LZ/fL2CLJMaAOfoPoSdQQiyiZf0uV9/WZOl
 QpHJ2Z+Yt89za55GRk2hWy35mBbgPvKgPZjnLR7VjdYcrTyN4JPsdQEF7cv4Y8i1G/Z8GBP
 V8UZ1+tDNCjbiBT0Ra+Qt2/p4A6ImQX5ZGCVeJBVYVeierKPVvh3DmJjOixHikjI8PEns5y
 myOV/nOYA9FZSfzF9hrJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xRtpnwz4jQg=:s95gCzy75SZ70KRdSgBwQr
 UEETewTmDis0cee6tSZzuMh0PdDUzCEEtJ2J32cE5ZlC1cF2GVgvUl5kR2yuvze2YMAeIkJIw
 r8lYGoWos/U1ypVL2RpKibbJdnWbLv63IXituSvzvCl7SnR7ltxQE23J0VP+MJpvuZir5B49p
 1CJSUYLvHL40C/nAoOIeGGun98QP+HgceO62qx/D26lSqwKAbWNsXnM9FQmp/b8dq312F7XEM
 +md/+Lmy1gQwdzYDyyqV6h2tUHZS18gf0+0xIS805nSgBr4/kDn/EBFQCt7Av9UzN65MtxrCm
 lrhnXxdyJtHffnvqRCs46rdL8kDAunZeYpjZT6+57qFgJV8DLBy7Ol6JA33hoJoUSlYNr6b08
 /4EnzOtL7E9T7ceHfMIi4AF8sZfCURG0YWwvPqTIqZtYX2LZ3C8CFG54+rNT7NzgNf0xHtvux
 vw1aXswhB/LOVeP3UHLEiLZoGkWiBu5ldtMSgeUJknUI5NcVPdN8Z1QguViepUt1TGWBN0ear
 3opevJAX/v0hVxaXMYik1optIIaix2PkY0rOTpCvj0JZg5W+yMW67KSEKj48ZdG+QEt34y7bo
 83kyr4MNipfpAsA7UGkapVHroPEu2kv/hRlWJQxHf3H9U7/KVJf6PrJeru6K5Ygg3SaHq6BRT
 IxSGZEqd4Y2PU9PmYcPVTZp0uXR504uYCCE8AY0U8K2m/SeN5clrzPQv/iL5akmiXPQ/EbHG2
 Fy0LBeD2hh7DIzFMtfIjvJWbuIdsXI9QJICt5KRG+ljPtcusWlbKllnuwYMXeGSaP7hSnqw2q
 9xG0mNLm+WEvlyySXmojcDoL7JQco9ucEGS3VVLaa/dEI6qaEU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


is there any way for drivers to add aux data to user namespaces ?

I'm currently implementing plan9-like capabilities authentication,
and I'd like to keep this separate by user-ns.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

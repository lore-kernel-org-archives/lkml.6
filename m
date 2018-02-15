Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033599AbeBOTsh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:48:37 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:54079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033540AbeBOTsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:48:36 -0500
Date: Thu, 15 Feb 2018 20:48:33 +0100
From: Lukas Senger <lukas@fridolin.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pps-gpio: Avoid flooding syslog
Message-ID: <20180215204833.4fe3ef3d@dinghy.localdomain>
In-Reply-To: <a9b965fe-fee2-3aab-0f2c-681d2835070c@enneenne.com>
References: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
        <20180215125921.29494-1-lukas@fridolin.com>
        <20180215125921.29494-2-lukas@fridolin.com>
        <6c424674-e8f0-eaf1-c056-889e354b43b7@enneenne.com>
        <20180215161238.23e0c117@dinghy.localdomain>
        <a9b965fe-fee2-3aab-0f2c-681d2835070c@enneenne.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zP7qBw6h1HflcF5KzrymSjLcE5LIK2aDqCFs0dLVOaLyPv8jsO/
 FU2mEDy6FlsqE/tcXqOVdke6COcEK9wj2tichpVKttWgUyUyKU16x494r957VcfBtfhTK4i
 6iURURFyDRk+rcgXRJnA2TFe2lvxN242fvxNw7NtXY1jHdaZKmQTEz1NfzRkBOrR46Jw2EH
 Si4L0chmMOhLKCeCCoAKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gNtXOXASreM=:DiYykXcXoIhymqXi5bvW84
 5Z/opDjDjYLdEPodvPxqSEkCPiDDzQ8VdK+1DDUQaWQ+yppvOFSQW0tqlVsNaOjQahiV5N6Z4
 QsiWO7WnU3A1XNggclcy//M1lCxS+VwmMWVIvOVtO391ty2aKLVceR/WHkqLpPg4VGtHKawwu
 mHF4U2B9ktea6bfaZzNTipm5rIRpAPotMOe/6+g1euSA6jfxLTKd6XgRM71A36TbBNnxeCNCK
 3O2esJZGWlRCouIrPnjnPy41hnuBOVLQFjD9343Wb7XCk+wrXLze4FHnamnSP8XHF0LBK3QbP
 CZnt0g3lv+au9JEJWPSJ2CixSR+FcyGUEfCPuz6GwyRuIGHfrwdIbKR/9snyR6v91eTo05Tt/
 GxiNVTuSE1oL1Ic3OVgFM1/pgqhtmVLZs52nXOSuP3fCBl8ja8GQcGfYtv0cQJCRl6ALsYQz9
 gA/UzRdbY26X0ets9ikCH4ehlRMLUTjbQzxwAZIOw4bDAf7P6Db1IL+dcaWIIrpCLzztWDJ4h
 uc/wcpqjA1CxgTbSj/RfWaQkvoBJzoc+IULpYGq7czyASiJ4N3rYEqgpxijEwQJMbHwQGRZWP
 hl0I4BejAyZJU5tKxPswFBQtUPw608yc8MAw7BLzeNCZRb1YtpDd2RSLITJN2rj15bzIPLFFg
 L/IhhjZxuWJVQSKZ+eKhbvbATP2dxlO1yYobkwAiuE8CJjL2Mr8Z/aw258ylr8gEtsr0215/r
 r4/Im/dHrgD7cUlfabV8vCA6dJx4PSfkr1OkDY3JWSCm73P4kkSS7mIdM5w=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The pps_event() function does it for you in a beauty-and-clear way by
> using the info.echo() function. :-D

I thought it would increase latency to use info.echo() but I just
measured it and there is no significant difference. I guess it was a
case of premature optimization :)

Cheers,
Lukas

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeCLRp7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:45:59 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50323 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeCLRp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:45:58 -0400
Date: Mon, 12 Mar 2018 18:45:36 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Eric Anholt <eric@anholt.net>
Cc: linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <258037433.356163.1520876736286@email.1und1.de>
In-Reply-To: <20180309233639.2029-1-eric@anholt.net>
References: <20180309233639.2029-1-eric@anholt.net>
Subject: Re: [PATCH] ARM: bcm2835: Add the DPI hardware to the device tree.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:R9PRCC/rE3uz9Vyu7FiSFOfEskVMAx3ysbgF+XL+A30PZ90p/6Q
 JYdA1ahfT5Tqig9kiVEu5nbCmM6W4uy3a0FQvMV30vROF2rnIWnWBHqKAUyW2Kmi5a7GuUA
 X725mR33/5vVClI7Ra7MmuffugMOppEwFgOlyNvwREI9GOJZrAoYqZMXvc6SvVf1hLkJGpG
 S6GDmlYik4pRwWyljLCRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pwamHl9OL5o=:ERJzFcS3ZwH997tY0Hb5qD
 p06jizW58H8NHAjzgJXOvA+NK46C84UKri2AS3A93jgnEhdA9BdEQqGszleyZwaVzfKBeRe2A
 trgOv+GWUqt+jrqhorhhH2UTcMRjj0D4wo4sCZmomgkem73stbtnWbjmGFKIl7RgpUnOuApnj
 fj9LZrDF1Bh4fsE1pTS1YYXZn2xHSo/JZ/LDD8rVlaMLEoZl9hjVcNPcLM3M+qMi5OIr0+7pf
 r6fYnXci/AGJoOsnGdnvxY2rj7cHl01xMrlFYkcnpqbG/Zbgq+Bbhku2LB6fvmP+d7mZBiLul
 IBs7DjM1m7GfPVLXjHg9Fzu8uLP5mi4oriUnODJCWL4KzSHj4SIXw71kxk865y/n0ZkkI2leJ
 1GuXYgxttUyvEMjDk3UDI7egc/R8KhRcZr5VRXWhUJB3O9yfO8OqAuMUjW/5eQUsCwBlRVWII
 rXwLAdq0nviGbJVQnvn9wglnrXEk8t+xDjFDzOsJbRAe/fdBxIgNPiftM7DeTLcUmBomqG/c4
 0zVrgjhtN9fv9jn8317wAzjxcCfTYRfEekGDFbqW0ppm6rgIS9RLhiX1cSyhbKY9EszqSWaf5
 inaO8yNs/1txyB9mZKnafkGxb5Swy5hNDFjpQmtO/KIdUQD5gXKvWQCWID5Jf6hjIMjTc9keI
 va89+Jky4bEtGPj8/u9PfxGb+NuZonSmj51DZJzBTYw79nU87+wmdm90CuhW1Rod1Lw5zggEF
 y3UxhJqgs0o7ydOIhiE/Y+S4ZCQufBH6/Rdbc8IUGACXDC9fD8QWlV0JCbM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Eric Anholt <eric@anholt.net> hat am 10. März 2018 um 00:36 geschrieben:
> 
> 
> It's currently marked disabled, as it's not useful without a panel
> associated with it and the GPIO pins routed to ALT2.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 

FWIW, Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

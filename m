Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965518AbeEXXSr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:18:47 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44952 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964852AbeEXXSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:18:44 -0400
X-Google-Smtp-Source: AB8JxZqEGMk4wTpc2loNP3nEYZZRHR2RnTuEjs4bw5TJC6CuFJBcREEuuvleLSwHyHA9AY8oj7Kyxw==
Date: Thu, 24 May 2018 16:18:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benson Leung <bleung@google.com>
Cc: bleung@chromium.org, linux-input@vger.kernel.org, dtor@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] IB chrome-platform/input for atmel_mxt_ts &
 chromeos_laptop for device properties
Message-ID: <20180524231840.GD177107@dtor-ws>
References: <20180523195645.GA92470@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523195645.GA92470@decatoncale.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 12:56:45PM -0700, Benson Leung wrote:
> Hi Dmitry,
> 
> The following changes since commit 96a938aa214e965d5b4a2f10443b29cad14289b9:
> 
>   Input: atmel_mxt_ts - remove platform data support (2018-04-09 22:55:16 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git ib-chrome-platform-atmel-mxt-ts-device-properties
> 
> for you to fetch changes up to 5020cd29d8bfcb3f3add43ea7d58b07011ab96d8:
> 
>   platform/chrome: chromeos_laptop - supply properties for ACPI devices (2018-05-23 12:48:31 -0700)
> 
> ----------------------------------------------------------------
> Dmitry Torokhov (1):
>       platform/chrome: chromeos_laptop - supply properties for ACPI devices
> 
>  drivers/platform/chrome/chromeos_laptop.c | 307 +++++++++++++++++++++++++++---
>  1 file changed, 278 insertions(+), 29 deletions(-)

Thanks Benson!

-- 
Dmitry

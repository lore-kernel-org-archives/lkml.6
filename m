Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933818AbeCELRL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:17:11 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:45750 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933671AbeCELRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:17:10 -0500
X-Google-Smtp-Source: AG47ELsGSOmiF87Emn1/pKPOmdfwvUQlv7tZTVVAqXXtmDd8v9BdAJDIC+Ld2ceKsTbjbHQBHj906s/xEESVXZaLVHE=
MIME-Version: 1.0
From: Srishti Sharma <srishtishar@gmail.com>
Date: Mon, 5 Mar 2018 16:47:09 +0530
Message-ID: <CAB3L5ow-gf0Z7NCRW1V0v+spRF553zx=J_pwc5m5YXxW4S27Lg@mail.gmail.com>
Subject: Unknown symbols in module
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I was trying to work with the iio dummy driver, and when I try to load
the iio_dummy_evgen.ko module I am getting unknown symbols found in
module error on running modprobe.

These variables are unknown
iio_bus_type
irq_sim_init
irq_sim_fini
irq_sim_fire
irq_sim_fini

All of these variables are present in the Module.symvers file in the
/lib/modules/<kernel version>/build directory. The kernel and the
modules versions match. I ran make clean, make, and make
modules_install before trying to load them. I am unable to figure out
the problem. Where I might be going wrong any ideas ?

Thanks,
Srishti

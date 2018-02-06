Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeBFLAC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:00:02 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:42460 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbeBFK74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:59:56 -0500
X-Google-Smtp-Source: AH8x227qJYhS57qwCnUk1REC34YHaVk0xv4hE7dZCIk7YjSxOlIcHyj2kEuUQzHISZ9vVzWgbid+XS1gI2hcmu6Mdb8=
MIME-Version: 1.0
From: Ran Shalit <ranshalit@gmail.com>
Date: Tue, 6 Feb 2018 12:59:55 +0200
Message-ID: <CAJ2oMhKgiRci76mXdL3mAxxvY58O82tO6feUW91hxAvXNZBquw@mail.gmail.com>
Subject: Q:uio_generic_pci
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would please like to ask about uio_generic_pci :

1. I have some misunderstanding as to how to set irq from userspace.
Is there anything similar to echo "3" >
/sys/bus/pci/drivers/uio_pci_generic/irq ?

In all documentation which talk about it, it is not mentioned (or I
don't find it):
https://github.com/rumpkernel/wiki/wiki/Howto:-Accessing-PCI-devices-from-userspace
http://www.hep.by/gnu/kernel/uio-howto/uio_pci_generic.html

2. Is there a way to use dma from userspace with this driver ?

Best Regards,
Ran

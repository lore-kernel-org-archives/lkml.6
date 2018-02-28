Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933347AbeB1VEK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:04:10 -0500
Received: from helium.openadk.org ([89.238.66.15]:42661 "EHLO
        helium.openadk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932790AbeB1VEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:04:09 -0500
Date: Wed, 28 Feb 2018 21:54:44 +0100
From: Waldemar Brodkorb <wbx@openadk.org>
To: linux-kernel@vger.kernel.org
Subject: xhci: Not enough bandwidth for new device state
Message-ID: <20180228205444.GX12535@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux 3.16.0-5-amd64 x86_64
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting these messages from a Debian 9.3 system using
Linux 4.9.x:
[  547.352746] usb 3-5.2: 3:1: usb_set_interface failed (-28)
[  548.352865] usb 3-5.3: Not enough bandwidth for new device state.
[  548.352868] usb 3-5.3: Not enough bandwidth for altsetting 1

I have connected a 7-Port USB 3.0 Hub to my machine.
I have 6 different Headsets and USB Soundcards connected to the HUB.

As soon as I start a C++ application which opens all ALSA devices
I get these errors and the USB stopps working correctly.

I think the maximum count of USB sound devices, which behave stable
is three or four. 

Is this some miscalculation of the Linux kernel regarding the USB
bandwidth usage? How I can determine how much bandwidth the USB
sound card driver preallocates?

Or are five USB soundcards really too much for an USB 3.0 bus?

Thanks in advance for any advise,
 best regards
   Waldemar

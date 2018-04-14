Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeDNCDA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 22:03:00 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:46272 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeDNCC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 22:02:57 -0400
X-Google-Smtp-Source: AIpwx48EgtE75u4JRdyHIMrdDiwXafO2w9eJZoFsk3qPzlRpUtHbl2rJIkt9CA3IydOEgRyP7ym6HQ==
Message-ID: <6ce634cb82617c2a9a060ba6e2accef2a15dcc15.camel@redhat.com>
Subject: issues with suspend on Dell XPS 13 2-in-1
From: Dennis Gilmore <dgilmore@redhat.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@dell.com>
Date: Fri, 13 Apr 2018 21:02:52 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.0 (3.28.0-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a Dell XPS 13 2-in-1 (9365) that when I supend gets warm and has
much shorter than expected battery life, it is about the same as if the
laptop just runs. I am currently running Fedora 28 with 4.16.2 kernel.

My laptop has NVMe for storage and is configured for AHCI mode in the
bios.

powertop by default shows
>> Bad           VM writeback timeout            
   Bad           NMI watchdog should be turned off
   Bad           Autosuspend for unknown USB device 1-7 (138a:0091)
   Bad           Runtime PM for I2C Adapter i2c-0 (i915 gmbus dpc)
   Bad           Runtime PM for I2C Adapter i2c-1 (i915 gmbus dpb)
   Bad           Runtime PM for I2C Adapter i2c-2 (i915 gmbus dpd)
   Bad           Runtime PM for PCI Device Intel Corporation Wireless
8265 / 8275
   Bad           Runtime PM for PCI Device Intel Corporation Device
590c
   Bad           Runtime PM for PCI Device Realtek Semiconductor Co.,
Ltd. RTS525A PCI Express Card Reader
   Bad           Runtime PM for PCI Device Intel Corporation Device
9d3d
   Bad           Runtime PM for PCI Device Sandisk Corp WD Black NVMe
SSD
   Bad           Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP PCI Express Root Port #9
   Bad           Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP Thermal subsystem
   Bad           Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP USB 3.0 xHCI Controller
   Bad           Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP PMC
   Bad           Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP HD Audio
   Bad           Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP PCI Express Root Port #1
   Bad           Runtime PM for PCI Device Intel Corporation Device
9d4b
   Bad           Runtime PM for PCI Device Intel Corporation Xeon E3-
1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
   Bad           Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP Integrated Sensor Hub
   Bad           Runtime PM for PCI Device Intel Corporation Device
591e
   Good          Bluetooth device interface status
   Good          Enable Audio codec power management
   Good          Runtime PM for I2C Adapter i2c-8 (Synopsys DesignWare
I2C adapter)
   Good          Autosuspend for USB device Integrated_Webcam_HD
[CNFGE16N092020028362]
   Good          Autosuspend for USB device xHCI Host Controller [usb1]
   Good          Autosuspend for USB device xHCI Host Controller [usb2]
   Good          Runtime PM for I2C Adapter i2c-7 (SMBus I801 adapter
at efa0)
   Good          Autosuspend for unknown USB device 1-2 (8087:0a2b)
   Good          Runtime PM for I2C Adapter i2c-6 (Synopsys DesignWare
I2C adapter)
   Good          I2C Device i2c-DLL077A:01 has no runtime power
management
   Good          I2C Device i2c-WCOM482F:00 has no runtime power
management
   Good          Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP PCI Express Root Port #10
   Good          Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP CSME HECI #1
   Good          Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP Serial IO I2C Controller #1
   Good          Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP SMBus
   Good          Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP PCI Express Root Port #5
   Good          Runtime PM for PCI Device Intel Corporation Sunrise
Point-LP Serial IO I2C Controller #0
   Good          Wake-on-lan status for device virbr0-nic
   Good          Wake-on-lan status for device virbr0
   Good          Wake-on-lan status for device wlp60s0

Regards

Dennis

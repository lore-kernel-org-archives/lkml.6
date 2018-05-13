Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeEMNIK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 09:08:10 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:55719 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeEMNIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 09:08:09 -0400
X-Google-Smtp-Source: AB8JxZpz0X5AzLkZBkgi8tGUZiiSYPmPwzTbdzIyxpnG7MgjO4C3N27mPPBybggowWUfipYo+rgonBpcPSWZ7gkwhog=
MIME-Version: 1.0
From: Dmitry Tunin <hanipouspilot@gmail.com>
Date: Sun, 13 May 2018 16:08:07 +0300
Message-ID: <CANoib0FoY86caY-zABHssXq_G8zmt3zJemvYrTyvQ1R58xseoQ@mail.gmail.com>
Subject: [REGRESSION] And a drity fix for 0cf3:3004 QCA Rome device
To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marcel

Since  f44cb4b older AR3012 devices stopped working. We discussed that
before that QCA released a ROME device with a duplicate code.

If there is no easy way to check which one is used, then it may be a
good decision to change the kernel code for the newer device in new
kernels.

But anyway it should be made cleaner. The device is still listed in
ath3k.o as an AR3012.

Regards,

Dmitry.

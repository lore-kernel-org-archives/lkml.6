Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeEULOA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:14:00 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:40344 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeEULN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:13:59 -0400
X-Google-Smtp-Source: AB8JxZr/qvMfINmpdKBgByqJyih4QmrJn9vH8eIyHnpkG2BTdIjI6qqZ6OUaBaiDB8QC0Aerl5TBy/MMkpBx2JN99ZA=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From: tedheadster <tedheadster@gmail.com>
Date: Mon, 21 May 2018 07:13:37 -0400
Message-ID: <CAP8WD_apEh=a8m2zJtUwcFpMRYh3ffjTbT5983413hrfE0w05w@mail.gmail.com>
Subject: RE: x86: Fix AMD K6 indirect call check v2
To: Andi Kleen <ak@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,
  I have a K6 regression testing system. I think my K6 is a revision
C, but I probably can get an earlier cpu (with the bug) to test on.

Do you have any specific tests you would want me to do on the affected cpu?

- Matthew Whitehead

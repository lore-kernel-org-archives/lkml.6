Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeBCUQy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 15:16:54 -0500
Received: from mout.web.de ([212.227.17.12]:59388 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbeBCUQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 15:16:44 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] HID-picoLCD: Adjustments for three function
 implementations
Message-ID: <1ef884c9-9fbe-b95f-d318-b806639e6065@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:16:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:PkndAuJxtoNlm8OsxfnVVxo6Ki1MAhGcCqAC87K2SB6n6bfkyh9
 ygqSaK7W+tlfxokQJnk8YdH7zQVqbznD8m9vuF46wYKuHS9F7H8uuo7i2xiQEBAPAv2czCx
 v4cawLnKkXRWHOkonLGId6sC+Vi1mrggdeziaNakZVaF07z3jKv1OxoliWpimOdLvwjxF+p
 ubFa266Mvb0ApOPAmtLNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V8QYPIghrKI=:rQNqrz69EFtHwkpSIHSA9P
 z+3fffpcvWpyUssVbLbsQ0YH3j9yeATSw8tsBGyREf0XM+PIsCZX+SEEUyMDaTbAxIt7M2v/H
 U/3wgn97hrblaXoFoyH0HwiX0PVUoV+Uhjguz6XtmDJFwlPooU05ZuNpkeDW9I3OQIWtd4niZ
 riXJ8UHwoNGKJugkP/AKEfNaPEQLRgOFZH/dpfp+Ir6g+tGXBu61oDwSVu8K6j94KViCGZwzy
 kfoOaBhWeamvyLCiCV6VJTczLHpjfY3sgZR+tWTtjxuFrcTajQTHLEpKxRIPfg6b/Tib8w0wf
 Z6nvUT4ApMETUo8N0I5NOTQjdPFx6bWNRfXGTClrG7ZkFGxkzTSDXWatMjSk3rCKLJU7+gf5a
 kP4CZETYWs+xrOb0WD/aW1hh1FF71WUTm8Yug96Ahme+MKzV3IQBCfNgh9A2eMRQVHE+XxoW9
 vXleclXiRTeUcPQikau59Y/qHFWvOnfCFYsRI6+3i/B42+WFZ4uttYJyLyxW5uymImZ+MaST6
 GJU/Q8emFxD7gJqS81ZkxlInOYQc8Gf/VWNXWPS5CpJ65sK6AfZt7+b9vsp4OvlD7E/IG2a41
 6f1AhL3LFtxzdypIojs2ftJQ+GHqyDh9FpA3qbzSzsTEU8+Xt7C+zTZ0uXtreRZLLtsd2CddW
 MeLaQYz9y4HFswGxPBCIkpQ14oKa2OZVOvUvRleFXHd7ya2EhqXU3zVJFasxtI1YqWPujGv9m
 hCopBde97lvzI/gJus+MNxsjeNfU6Ezt/3UPlxhCVxnLbiN2axA4xbMbWtM2C2sAo6dAto+Kk
 UAkVJ3C5hLW/vMw6M5eVh28ogDn3611HJcM/2tLlwhcBOPJ+U0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:12:24 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in three functions
  Improve a size determination in picolcd_probe()

 drivers/hid/hid-picolcd_core.c | 3 +--
 drivers/hid/hid-picolcd_fb.c   | 5 ++---
 drivers/hid/hid-picolcd_leds.c | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.16.1

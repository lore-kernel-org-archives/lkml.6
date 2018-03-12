Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeCLLaU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:30:20 -0400
Received: from mout.web.de ([212.227.15.3]:45195 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750988AbeCLLaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:30:19 -0400
To: linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/5] Bluetooth/btmrvl_sdio: Adjustments for three function
 implementations
Message-ID: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:1FO3v0bWLUtFZuydM3zuXtkIFAPn8Yd9XvYjT2H7y9tNGi69lfE
 7vOpFpan43HPptizC3BnPAnKeFcGnAgCRoQ3lmneB3xPtqpv5Mc6k8RJwTadqlNdR0Ub5n0
 o4bzaGUS+jexoGsRXhh0TZFmc7JpUOSPQ1E8NAnSusnMJu5TCDLRM3Obpivh+ur1VOQ81NC
 W1BnD8hnISLwETttvuP3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RirKkO7tYIg=:a3vWLtrr6FuneqHSrNXBfT
 2SVdj/GzZDSsfFudx5lYVZiO5Q1TK6ZBrPajAhOw428+LYtLMgPKGhqtK8P4BtO3SxEeqCMmb
 LMbEGxZfhcNzFqWry0LJ72zQG5459BYtvTmJwnVxAfXjdCFPf1FYNehGA280UHsiQl5isfzJM
 gTyGIeEjrrNui08CX8e44/mvFapB9JdTX8ehY1Aydybtc0YX3j4L68dJluVmXlHMoZKjLhXyV
 KwWVPBnkSz2FT4WowT65klezkw2mgGSAOKtNfxDxs2F6v/Gjae/uvBrVqIWGoiiiONqIdXAiB
 8FfDVIXPwMTKGQKCZCNU5Ajljtq+EsIoRMn381LRabt6pyLTwoVnPzLpS95Z/VprOFQDsBOsL
 HPGDKwMESpeOt/bQtJzVzlTzutIxyj+1SiqXemdvNQI0/DDDeR+nJ6AVIu04qPWXOSPxKF0WZ
 AVpBUwF3vb++gakrvU/EoM8X2zHTLGERrvY4r7u2BfvBljxGY9av2t+/zbe4F8olfDjQ3xj0t
 3+b/K4qJr4N2nHdqnqNyY0ZZsR1376ih6V2qPgyO9Eqk/qqrfiAmWDRF0xhS469uCwCKpBCET
 4CSNKo11UUWJs+bpvYi6fN+Wsks7e2WIOXQddKrlOxn8ptgvpcIgdmjsj69i5okXpYJoXMkbk
 Yx4ukeb4jg9XuiKLD8PDNYV0EgTYtu0D15etN6a8O3DqXT+LYFNUZZDb0sVU5dZ8kYj6nUOxe
 9/yRBjUktxAX3JyF3SjUCIzpBkU+pw83+FAYUO34v3B+UMkIAosU17XlnOn/gcHWDUFY3ut60
 uxPAZFYTdT6wBPiBlik9+sQ83zrIns6UG/sxuUxZFlpoFs7qK4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:10:24 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Use common error handling code in btmrvl_sdio_register_dev()
  Delete an unnecessary variable initialisation in btmrvl_sdio_register_dev()
  One check less in btmrvl_sdio_card_to_host() after error detection
  Delete an unnecessary variable initialisation in btmrvl_sdio_card_to_host()
  Use common error handling code in btmrvl_sdio_download_fw_w_helper()

 drivers/bluetooth/btmrvl_sdio.c | 102 ++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 56 deletions(-)

-- 
2.16.2

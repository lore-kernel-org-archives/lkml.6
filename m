Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932178AbeCIQKp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:10:45 -0500
Received: from mout.web.de ([212.227.17.12]:47577 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbeCIQKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:10:44 -0500
Subject: [PATCH v2 0/2] mfd/sm501: Adjustments for five function
 implementations
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <5271ab9f-3be1-035c-90c1-8faba2e119b8@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:10:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:KhQlDDYfeh9rWKDtlKl/3eiqDf7oOtWZSBX1C5/xBGiJ0NrEMDo
 spKupcRUMBgfyRuhcLPZwAVnNJugxiFDT6PfHxKefJrHGXa0FYmzFF5bjFtTQDE7kS0cUDQ
 h66Theea0zeKhsAQGgpKDCXkxBOIwq+1lsda3p4biuCAFhgV46UKNq5cvo9luGTE/xQRSd/
 Tj+c85EIyLYDfCqTtHqjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6zEtyzeKnhM=:5aOiZlVXA48trtQbtxnm5A
 JSfu9I9aYoz0RBYpFsw6IPQ1cpJHDY7V1jQv5rOZD6Cu99xC4GB34C31p+tI0FyytZ+BWfliT
 2NRCT79anFR7SnebOZTT4sTIDIb2qpT5NLyzP06uvXRTRRqQtGlpWmNecYel+T7RiObgztkFD
 EBH+lEpklnHENzc2U065rLxIe3wijTqQQNVzDOfMqR//83sTz40l4tOC7FlzDOhzKUVtLhXSK
 P8q9BFejRIFpAbEWnbX7aCEwOeMXIhZPMzizUaVaVcNNIsmhcfjMvC5WEt6g7d66o3TiOTJ5g
 4ULfA8F8FtFkzjc86d9QEm+S+hz1CN1K0hGoKeEdLV6VYiUlKjdivFTfJ6xM0Pv/kZO3i0YnR
 DcN1nnV2yiuXL41ZbOaAFBWgQZaFYrVItDiLI76SDUX5O46/mRE1k0N5aQ9BMJ4BuBogfm+J2
 W78sKLqZwgg8kKT5SC8iP5/JSVWtr09o7D7dA9S6FqINIYte01xN+VxlNLIMYGVU/Q//3tOOA
 hg4/fNOSqxFd4/Itb5Fh3WmAIAVPmppUWUBop+EtrpeTznOIw25QutO+3PeV9/9L3IqiM7Gks
 yTyFNn/g6ylOGyzkf8n6961TgsVOLwBxfMD6OdPI5dVIV4YxEnUMP/gk3xM+GF/folKtbz/If
 +hFVc7nj12uXSmdPPHUcFcdHOjZhYDC0TKjeSgiQyxPkQdtaclD3hg74kU019eP/tFpM40dZV
 ZRBA/mHHTV6LSRdhnqHWn4ts4v7gAGXragWfKOGUGay6G+DWlFJAwjE4Wd2DyC1BnXbWGCaf4
 xiSGpCQ97unTahY0rd5BLHJHEDeemJIP6l4Ih7CQxJOy4XAdNg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Improve a size determination in two functions
  Adjust 12 checks for null pointers
---

v2:
Lee Jones requested a resend for these patches. The changes were rebased
on source files from Linux next-20180308.

 drivers/mfd/sm501.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
2.15.1

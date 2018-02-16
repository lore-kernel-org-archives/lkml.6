Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030882AbeBPP4d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:56:33 -0500
Received: from mout.web.de ([212.227.17.12]:47453 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030613AbeBPP4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:56:31 -0500
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] PATA-Arasan CF: Adjustments for arasan_cf_probe()
Message-ID: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
Date: Fri, 16 Feb 2018 16:56:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:uoBcl91jlXMpquX3keb4jfBExv+CcOmVjNebc8EBpo9vHoRTtDT
 9aD50UP2pTBCuBjawpRoZHroKgwpJz0+TNlohWDvtFcWC1iIwcbsb0sYX9pURRPncKdLuGb
 me9m9QBjrhdIp8ESSQQXUtJgWBOTt2vbnNd2fRUcpPaMcCET9bmn3jjBmo9wozu38MAmZyf
 FOrCd9lwKjE7Jq91esssQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NRP7QoE624M=:p0yQg1Jdk2TmlZzh/7kuyC
 re/AUQUT8rgSpgjBpIk9SXi6kLFSGpV+qrMyALhbOuoe/h6KW6whEmkhgTaW82f9+QJezqUzx
 uHGDnpD7T6oXnrvz2nlk3ROssWqFq4IB3/qfqSOZ2OibVG0OjM1Ltlyjaw8l0ta1OV01/asfH
 iuut0+zzLfM/8rWqVgx7ZRdHLywIdkn34F1KZ+lMOHwDrpUklE7GqWg/86KdDIUn/cCISwUqW
 c3JTUeftYsiDn4UI4L2OHYhxTK6wfEq4Wzcb7xbgSKU3m1ZDAsXmYwasXZ26WWXGvmVwqoPkq
 OX6drRaEzjHMICS4KUQQSl9MlyI+XP3kfLKLxItCaNHbF+EJVRgiGiyR+79j04mOz4ekUuJUX
 NJw6QqWtpxaBxNzaOd6PSoz24QeqkK/FSuh3EvmKrJY8dMbt/Tg89A0EmFHguN0Gl15F68u0l
 jhNPTjg4/ujWJLmJSJqVh/CPth96Qepnr8tU4xI8NUOuyVzev33ew3QT+a3bEN9jtPwk1rC/t
 nDQTM/oAfJM4yLXaQUWPuVU/T8jY3x4UeO1Fkl1jXiU9HUpXcE4KAdmb36Tdgo7mqfqK/1a5m
 uyNf+ddLc/yegGYaamMlggk5Kz8B576bz20x7YEktVIljGapE1ncyqpN1CG542dC8TmAnMIiv
 ShGj573MU+/7hq9BT9Fu3jh5hPRtg5740KHVILhSMz19/Ew1DxmjahTR4x017IysGAxrSZbyb
 4hRMGnMsxBkUuXUxfv3ENwhxuQlZx6brQ1kWqAy/OmnEmP+iSUd1tmDwBu68MNPQY5aZnTc8I
 BaP3Mghwh3xFXXVa/wLO5eBagfn7u7GjDNzkw6ZhUkijZBvTV8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 16:51:23 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation
  Delete an unnecessary variable initialisation
  Move two variable assignments

 drivers/ata/pata_arasan_cf.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.16.1

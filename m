Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033475AbeBOT2l (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:28:41 -0500
Received: from mout.web.de ([212.227.17.11]:52647 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeBOT2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:28:39 -0500
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] cpufreq/PowerNow-K8: Adjustments for two function
 implementations
Message-ID: <4dd36236-fc39-19e6-c1a7-a094cf13469c@users.sourceforge.net>
Date: Thu, 15 Feb 2018 20:28:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:GJNv52xpJ1BdvxKTcWvEujRjrDh6V7EYHXkalPHm8BklKN2V3eh
 bCgNmjN3j2u4W0/yFWWO5XXzNcN8nuMP9GgZzUjg29qEqJjJW2ou3cV2IW7Olgjq1aLdAiT
 3SO2lTiDGgPJv2zj7QXZ+49dIukb7mBJ2WdwaQ9tJ+NIHKBMgS1HTwO0wFbzku47Ofj9Hrq
 z+vSid5ENQI7SwYImzV6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gHDamfUBFys=:B2mSxhzz+jWAMroLoVOV7Y
 Z1AXPPQil/MCejGdfhfloEuMoDiQIVUDLiZPXVSWJU+eaFk6jIk2iTJZ+1Csy6D1axvdQz5m6
 Djusa9elz7kQf/oLKisgEu9QjBnF1+ocN/w6qizC90DBAj5fZVoc0zbUok4hZ4RykpKoQ1d9R
 1oOZZgwJRPDmR+C7UbfHjVBlDGxXdDY662GqbKuDS9X1uurP0O6JKwctPVhVkMXTynYfJZ9ef
 KAt6vKLxSz0KL66lhd+I2425Alhrn/AFG/wSwk4c5ZBHlTyFaueNQ9wi0IjKgeWTxgQegZ0fQ
 2VcqEopYTBEfDKaxauJJ3K/mhiMg62MlJjXfjnRcS5HXOQZ1N+zR4xqAEgDauPoYW2c3H8tay
 eMvN7UM4SAo/we62B5ygrPX9nywg0V6MqwzXIHhgSJTtX5MYjozdH/GPTwsccgjblxzwg4k/Q
 o1P2q3q3emwjCIIio6yC6/X1HQ7vs8vVHB36LIgafJUdB7LyCyyuNLffjz1WrBxFpPTl9veP/
 uCiRft86I0Ota6K2eJq+LzOD2MPpIJTVvlSD/g3WDwmKQ3pUjpEdTQNAni+EHXy+lLwzOGp2U
 JaQxc8OoYmX6SBBoHc22QbumYt1ejToVjiZwaEPX2ywqyCJWh4wH6Ywg+Vx3eeyILe3a3nWti
 1ZAE0x01kLBDXXY4uCYrXmE5/tsxpt4nXORxMYcnMFkc69Xi/onWKZQhEXwDQntUHT5wXy/OB
 qJDdFIyZOEBD4Myj0/tgcu7wBdM0Hy751oC+ocTnp3FBGgFl+BDXjw4k8a3uE1b6hZ1fgORoF
 94lpV3+DcLKltCItaCPIRp6pPY6brN3ZsHWw4p7/4w0LtlFj+k=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 20:24:26 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in three functions
  Delete an unnecessary return statement in two functions

 drivers/cpufreq/powernow-k8.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

-- 
2.16.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754123AbeBBSLj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:11:39 -0500
Received: from mout.web.de ([212.227.15.4]:52771 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753120AbeBBSL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:11:27 -0500
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] I2C-Blackfin TWI: Adjustments for i2c_bfin_twi_probe()
Message-ID: <740e31b4-79dd-a4bf-a2f5-001c44864b79@users.sourceforge.net>
Date: Fri, 2 Feb 2018 19:11:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:7N2VNNryvEz43kHMUfyYp1jvaO6ZKmU5bX3uf6OBbCenQXGoogm
 370p1M9crq9bJlWGkTJv1OaaDWnH4nCxhtITii7OrSCjQQNB7DYiNg2TlTGOAUru981XsTx
 4v+u6Z4Aycp6Kz2jAEmir6cxXR+4m18JfgTADH5N4UbVSW7yAhl7hu5uUHPGT9K5RMZyBxX
 Bqge+uGLaDRILcwQbzGQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+5KkSbI7b0Q=:/7j2WAGTZu04OBUde0PEoZ
 99NyU1jy+/rUqjr23f7QUsAV3hZVvzBol2qT0Kktz7k7sBc4v8G34GlsC34hoa/eC515ZEMlP
 JxQX7yJibJIgvnUQa6Lj6EeHRaDc+zMrL2z1XpOhtbblhtNSI/lCMA0kXZre0ewqcGO/te7+2
 7gZPmyLKjvtdWq4eE5H4sx/K+f47BWob++xDqiN1ZuehSPimCCYVCte7Yyj2QIpUiHkKnKfub
 CWEotMxseGBj7OGOjh9Z3FcjXacglZ3vQrHWzPXz3you2fT+f3oQc95EOAdNezZFft1DyogvL
 bCySUgrFSQOFIQwQqRPhgfTZSBcgabYiGDPw8ACcjGpeWO7VdUHfkqhvXzL9fgvFlc7r+DSc3
 OF76hLtrw62sBd55USqF5cUmV8Er0kkz/j40NN0pGw2RVlsad6S9eM4v3ltxxcIOqdz3ROFGr
 0I/raPr9dKfYk5LrqPzEuhIKgJszQtn2mCZ05azdY1pJdPP6UzedABsT1t7ZVqFtRUqqe8GYq
 Wm0TcQx4GJNgqGJqBBjHZ6but/vcFA7QR1HP7FrpffLa3S7iF1ZxrvJblYJqojNKgLbyGW2Jj
 3u18khbeC/uhx0XhDZbEbfWzHblwteA+6E2WBYr1Ped18YtAXOQwcjsSA8s+NpF03QjoeWLun
 ofcBiapUWivsaLSWcKhh1Jif8jU63sbz2v7arLYq+3F64XRYbAjLO6kFGm11km4gTYbdochBl
 EQftocqrZv5RpwT3qfHgv2mMNTC6QrKqZyVi+Asw+Tf0fU3N7X2eJcOJ5a9RM/6dQYnpRo+61
 QEE/7pEZGTye0x6TAps5Omqodv9hNNLzWg22deVCo5Dw0/qMvE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 19:09:08 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/i2c/busses/i2c-bfin-twi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.16.1

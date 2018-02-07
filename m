Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbeBGVon (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:44:43 -0500
Received: from mout.web.de ([212.227.15.4]:51150 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbeBGVom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:44:42 -0500
To: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jordan Crouse <jcrouse@codeaurora.org>, Jyri Sarha <jsarha@ti.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sushmita Susheelendra <ssusheel@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] drm/msm/mdp4: Adjustments for mdp4_kms_init()
Message-ID: <e090cf0c-0bb0-d28c-ac21-9e045993a995@users.sourceforge.net>
Date: Wed, 7 Feb 2018 22:44:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:eGE47U9UPffA0ghjay1zywwkzYx7/hWbIEbZ37WN9acT7nn9zGz
 NQUcwsCgbjLY0+N3xzb/8UFC0fuS3c5OsZo+EV1wGNG5J+KUQCJPA/IxRQStHL/hVLL4gF8
 rQ+IkjUye9Npq0kOS8LBoxINMIumICox4Cv16EjgmBM9jkhllNDoQ3GHqb8pr2gnmLthcYx
 Uv9WLosLahStaV/JSr8jQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7QrR8yK6mZk=:3RzeYlwbhk0EBJFtg9qJDt
 VLQmiHIuZ1B0kIC+ff26eC6rPTh5Jz+n7jqHNotx0GOaXKhkWwSBuRMEg/40vH6C4aYzV0Kuu
 1ADwch8M3a2VyyOmlG9F4804y21Z7WwIECuwuCB3WhPtbeAMGnAHh7KXT6OR7PR4NrXLNtb8d
 +kahynaXXGE5Q61QTn0DM4mep1ot3ERyb4tavnfcl51TcJ3j3SZUEBngf9JKJrU1qoaLdgY7c
 OLM9HuH3kWoG46i8+i1Bwyu0hGGvtBm0c8WKVXCRycUfo9dq7oP0svWVT21SWXUjDQVauV8e0
 vOad+7vqr1+JeYFl/z+JK+quHbWndesFxnpKDD8MDvTG6QwchXUbKJzBlz7RfS8MBvWH3sfNC
 0/3DEX7CyJADusGzFF62VjZXjJx9urTqjlIvZXiJudHwi3NPvqXstkUfEd/x3jFednzz2pqQm
 QR7p7TS6QCHXeT6h+f2GyU+78F0xUWXMSo7z7VQm558Q68Am2JBLoquSKoqY9HLLa4ZoGLGoV
 Ii2KE9HRum3/bYrB8EuEGTp8LvX+SR91KHgkLduMQ6c5dhmzPxfYJGK3G8miXdC9u6cFn1K24
 zVPoX9c9cYF+ec9GvWXW4+2ASGU35WP8JSf5chMtw6UoAfMMSZUb31BLqjoH28gZl1BWnXelm
 IAY1bNzBEn6tflrYmzjiYBh32IFCSdetM4COF0eIEjTyMbyxla1x6TMk9zM9JJWh7CobnTeEx
 JWbqct6hyGbyrj90fJfqyQV3zbd1lQ5nwijaKxI3iIxqabx0RPjMcCqk3F7t+lH20g+4MvaZ3
 ejo+s56cnqGiW2bamgbIBJ8UwHQrcWrw8ipGlSb5FvekiHW52Q=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 7 Feb 2018 22:38:44 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Return directly after a failed kzalloc()

 drivers/gpu/drm/msm/mdp/mdp4/mdp4_kms.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.16.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeBFOni (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:43:38 -0500
Received: from mout.web.de ([212.227.15.14]:63239 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751424AbeBFOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:43:29 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] HID-Logitech: Adjustments for two function
 implementations
Message-ID: <5c76a767-b1cb-2486-f24d-0d5a220b8985@users.sourceforge.net>
Date: Tue, 6 Feb 2018 15:43:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:aYsZwoWFhRIOE+K1af3Miemr1DH2iGILV98zYgwZNBd8Z9l14Xr
 YkX8PZOXE3pgBI9TG/0y+gdH026BmY0epHIw9+AFfcm/jRNWx96SZWeHDHGe9qqYjYeh78S
 h+q7h/7hVaNBHhpOMfEMKBCSBZSSMXvvP25xs7LgUobYP1MSOohiL/V7eD1M1G5TDZ1oNku
 R9XBQvRWhXXi2gEbZN9/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2JsgQM79E5Y=:xAATY9Kuxz/bsbbA8vE2Yp
 SPD3IKBvvsCpJ3Hh3mvt+OWGiLZTSFV2uvMW29iR3+QFUArCrinzfPXcT1UdBnnTVO68x8KVi
 q3RZay25uAwUj5ZZqjg3f5UzCaFbZRq9MEtzVqTsSeIVSa/jENftkcq2nn9B6VnyUecB2tjvZ
 La6oe8+zNUWQJt57MajRFQykEoUGYC5Z8CjeWFTjvJ3MKMolu3ePjiojqRTF93knX86rIP6HD
 LjqlZAWDKocP9rzhNUbXfCEDmUA6XKcTTmdSuXPmYpSeDup15ejX79faTGQ45fsPAeBxEpeCK
 eIu3YmxLreVnQkVyXM/sPfjCO66bM4DfWk7xZCb5feqeTL8idDAQX1cgP2NSbvpihT3MF5/IY
 jrhXimMPCJEh52520HBzfxbAk7KXEYg4haXTPdssMFCWRvfAGqJxpdyAwAacyWqszcG10gdOg
 CM4pIKBf3Ev6Qzj2jy+GVJzDrzvn6O+dnInxM3eBx1dXlcPa77m7gGkINuGJktAxApG5Oi6gZ
 Cjy8wq05ysNpwvWyZvSf9GnjNUi/JE/8nffrLFFt7PBC/0eimUy6FXOVEk4bbcpl/Kx7p+lig
 2zBK4/SQV2F+03CWb4TzuucMh+tyvf7222vMLAEe7rripqYdnYSD21AAXCsVDR5ijjipmU1Hf
 eUhoFWjIXsAKk7Io1rk9DXYzFyUG9rg8zdpHOWr7fI1UQ2uritpD9WZFGqjEQnYQXl+oLxtSC
 dbUi0PVW/G1Es5oYWjYPQV7gWp9KKAO3cH1NlSqeyAZhzGz4/3QuOZopbgwwNK7OURLsGMO4+
 6sSN9i1cvzOvvHwy1LoAz2OHBqyrkHGf8mHq4a8kYF5WmvvsMs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 15:38:30 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in lg_probe()
  Improve a size determination in lg_probe()
  Delete an error message for a failed memory allocation in lg4ff_init()

 drivers/hid/hid-lg.c    | 7 +++----
 drivers/hid/hid-lg4ff.c | 4 +---
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.16.1

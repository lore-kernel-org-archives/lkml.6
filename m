Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162155AbeBNSaf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:30:35 -0500
Received: from mout.web.de ([212.227.15.3]:45961 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161903AbeBNSad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:30:33 -0500
To: linux-crypto@vger.kernel.org, Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] crypto/caam: Adjustments for eight function
 implementations
Message-ID: <9a9a602d-93da-457d-c37d-2acbb4b7b5d5@users.sourceforge.net>
Date: Wed, 14 Feb 2018 19:30:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:QzOLIaWDmLdKc7gjWmonN/UlPoUeWxjPc848Kr/8syC+SciG4Nq
 rxTKcrBvmtX/g/rU26IODVqnGgQTPmQlBo+eYDJuQ5nuJm3ZpwUrVs/odc+sIAE0+ny8K3E
 7/sT4TlFsBOA6EUd/F2w0kK0VX6/nUd6Svo+zoHysoikFGkY0gXAP22rUh0NfhohHQMlLKA
 2uN2E1CYjLMazZ1rnY2ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LmNRbXbIEeU=:KgJHhfgDBXzMFhyRCbJ0pL
 jO5HyS22pzeir/N9iMZJ2n36k03vmLn+ZjK9+4slkdRytZVWfM4oTSXglY74UW+qdAde1dQ5i
 aAuu82w7EAtWLf/XlSAFwSqt5bGz9SsxTShR47DF7tkh4WmiDRUn29adtZfQGt5kDKL9gVs3/
 UM3ZHMu/ZGYgdTnh08QpgzAG0ulNLoRMylN4QZxTVpP0qUnn8IFaHPuh4B4Cxf8cHMLFNDWPT
 kvRLdjHbudpI2Qm+5LrzL1UXkrr9EaUh6NFAvacpq+7owqIgFuBpQB/pXha3ByVlSgBrefb5x
 VfxsOhM6j/GSoYWtw8/dczdUe/p47ZZ/TYkmOMWZyTXqkP1Vz/5uu/IqhD/d/892aFkSCP6nt
 ignnqCHcrDPotDjws/HLsdIa6FawW7yxc3uT3dYwKrXB2IuKtd/SVrvqB2gzqbL6wF6J1EMTG
 wRWAuK5BisUjcEG/Z/YvGxlOiC7auZFPOqUQQZyi+SOE43cA0iZoyZIHzj6ZC3++LvytNE+Ji
 tHKhA5A7sMP/9URVOc7IEgqTSYR4fe7fA7FIV/hbyPA/NRMhFl1PCEjF53LOoVMmh//bB+/su
 U0JadsuJ73vFK7OJQSrCEVrxiXV2do1aaJW2vk4eD6n+gwjHmQfvkXFRRAJzZzHd93qU8Zvx9
 QlB+NqGnfNrGxYkBEPsGUoc5rNJOyKjDAhS6jlF+53SfDRV7zHHaJsmzDs67uNhQHfWRhaVbc
 UU0RvzNmbQVZTjj1N+FCSl89R7lku6kw2f30tYFDSWr+kbbxa6hujbADr8lQtLDRI0oC0CoEw
 PCnb5Rzwqw+p+kzu8SqzvPF86d4JU9FOtMmH7IUuqacjUqkHZ8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 19:23:45 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in seven functions
  Use common error handling code in four functions

 drivers/crypto/caam/caamalg.c  | 38 +++++++++++++++++---------------------
 drivers/crypto/caam/caamhash.c | 35 +++++++++++++----------------------
 drivers/crypto/caam/key_gen.c  |  4 +---
 3 files changed, 31 insertions(+), 46 deletions(-)

-- 
2.16.1

Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3115974-1517473424-2-9638920338341898423
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517473423; b=FYuluRgJIS/Y2fVSoto6Qr+glitcnSTba3LYdwrX6kClqZM
    zAxLBglVYOGjmqMkl9DaSBBf9rCP38RLtg1VVRv+cyLldvD/0GPmZuFLKdt3VBIK
    7uHyca+1OW2EAVyjOrZgqnuGLJcIM1SM1N+OHuuEfO5ZNwBGuQSENmVLuNdTdjWO
    aoXQGzlCSBT2RBf2tzGFWxciA252+zafP+ZHi7PjZZBdEwUsqIb5a56N6Du6l9mM
    DWiR+GtX58YZB/RwoabwIgnEp1dOU0i6pT+DhYTfiFWIxF7sldlJvCabeY/0fbbw
    nrwfykDeu66setJLNdkIMi+BOf/mSEsPjEbkoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517473423; bh=8
    OR3Y/3Wd7ax/t/kEFq/be3BMkjtRdYgN/5wSE2d4FA=; b=jhjFA8H9vi1NA9LI6
    imrCK/nqXDDM5PMMtf5yKKt81NCFCc+RmtA4XilaDnDHv88Hs91tCHuhw5QvTr6o
    0j+/nuPn6Bbp2mJ67utzgdA6cVo4U/Bin2CPIRhFLDcFNpioN2zqS/p5GUyaQ8ee
    nTuxqLeRPsxM3demoqrzAKM76stdnsdHQx6CTa02uU73BNlcgeWOBwVzo35ou8+p
    cOvW4dsTuhs/qIwo/monkm09RwEsnviYflrdkcjRftou37quZhGJyGX3TwWV9a+b
    VFTriSSF7qeAtK1PYqklK+1h8gVB6Hc+WrsoCkSL7vQUW/Kg0fA4c7pymj+xePMf
    BkOdw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=E/AVr7db x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=E/AVr7db x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 1 Feb 2018 11:23:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH] Staging: fwserial: remove unnecessary parenthesis
Message-ID: <20180201082325.bb7hfaoqxuavee6o@mwanda>
References: <20180201053951.18688-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180201053951.18688-1-quytelda@tamalin.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791
 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=905
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010110
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 09:39:51PM -0800, Quytelda Kahja wrote:
> Removed parenthesis causing a coding style warning.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/fwserial/dma_fifo.c | 2 +-
>  drivers/staging/fwserial/fwserial.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fwserial/dma_fifo.c b/drivers/staging/fwserial/dma_fifo.c
> index 8b23a553fd4a..ead71f93f3c9 100644
> --- a/drivers/staging/fwserial/dma_fifo.c
> +++ b/drivers/staging/fwserial/dma_fifo.c
> @@ -259,7 +259,7 @@ int dma_fifo_out_complete(struct dma_fifo *fifo, struct dma_pending *complete)
>  	if (list_empty(&fifo->pending) && fifo->open == 0)
>  		return -EINVAL;
>  
> -	if (FAIL(fifo, list_empty(&fifo->pending) != (fifo->open == 0),
> +	if (FAIL(fifo, list_empty(&fifo->pending) != fifo->open == 0,

No no no...  You've changed what the code does here...  I'm so surprised
the compiler doesn't complain.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

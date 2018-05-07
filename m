Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AB8JxZp2j/AIeDF173cj4ic+4/dOg94H63sESwexUhcNIXgEEaHn/we1e1/tklh6XpPETd6eFW9y
ARC-Seal: i=1; a=rsa-sha256; t=1525696749; cv=none;
        d=google.com; s=arc-20160816;
        b=F0JlCohlpfJY7lbzf/803J8j+bekIg/aU8MK/+6yRJye73jE0fn6C/n52FYb4TEQqa
         cPL9GDCC2qPJqOpEn/HX40SQ1DhR8VEZ6W1Y1FDiSRznMyCy+uy/GwyHGfu/BfNpp4Tq
         S5F5/9Ki60+O7Md18QvRXUrE81Y7bcg4ERB037DXNS4rBh8Z2sn80OPX3QvKF2XTkTuP
         Zq7924SHyN7FFG+mGG8vtjH6KRSdJpA2cbys/X2covhFtfaMqR9s0w51J/I+Nj987mXR
         jF2LcFeWhz9X448ttwpZYQUiXUlqQr46+bdtxDPUa4DW+xFeYgLp0hlJyX/h5Es3JkR1
         Gh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=sOg/BT9bEO0REqeza/vQSCCih2AvxVLJ+j4noqgUy2g=;
        b=rMzciQI+D1RvV9PY5BqvoLU3BwbCn005cAs+1D26wMNKCHfVuYyHXCd9BKhPIKb0qC
         mu4yI2Wxf2VpjJsB0ndNybu3sBd4t9Q9HkpjgZL73GresShblQE8372A97PHcBFtTJ4Y
         ufGFDY334/BeQw5jTDM8JDGnNYK2hWaDwD+01B1rsgeqgOiw2Bv6j9hO+Rs3xqQ5BOOM
         M6TJCAs6oLyjyK9MHmxir84On9rAYHsRWEl9OTOPMG+yPBtEHjjHub/zFN5odQfIQmWc
         2v5rPtscZGJNdCkOTJo+KClopz+AGb+EsW2egs2yM6odU1XoYoot2ZKwq+zZJsF7jX2C
         1H1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tvr72W1j;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tvr72W1j;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Mon, 7 May 2018 15:38:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, gregkh@linuxfoundation.org,
        w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
Subject: Re: [PATCH] staging: speakup: Add pause command used on switching to
 graphical mode
Message-ID: <20180507123842.lpya3xjqqshljkkv@mwanda>
References: <20180502005610.wck7uovcz2twylch@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502005610.wck7uovcz2twylch@var.youpi.perso.aquilenet.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8885 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=428
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805070130
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599310790536411239?=
X-GMAIL-MSGID: =?utf-8?q?1599808995201234049?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Please use scripts/checkpatch.pl

regards,
dan carpenter

Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AIpwx4+Ss7RtyM17JxYmDoK5Ay6faz4BA18ts9kLAkFs7QKVORYVzhDNwJpiH7fHnoIOChiWh5Az
ARC-Seal: i=1; a=rsa-sha256; t=1524721104; cv=none;
        d=google.com; s=arc-20160816;
        b=C4vCYK0eE21IAVMTGcvs+u2ho3LfRcfgCCoxy/OuT6ygkbm+phRAvNr2ePa8oMGZDv
         K3/71CULBCcDl8C/p63BReDEC50FcIgb1TiYEA0UXEG85VUgeaZXlXG/ovEGxUFVPqOT
         0r250bdwp79GTBLZImqwevNhk/4f15aE356R8HaF6gP2L7aK7Ngau+z5aO87pB72SrhN
         JDhX7LA/a/z8o8WM/22WW2wtQNguKmOdiyzWvBL1qhxuR3LbEd/a9o2C+ZzzYOwPmDGF
         bY0i6zcgEtFksmFD9QGlnTCp+VO+plviPi3E9vg/DBa1mbPansjl6rZmyfu3r4KBIXyw
         SCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=KTqh/sFMvehrzBFkgx/b5h5acfQCwKu8MxFu8XjCYiw=;
        b=PFr/dQ0pQW3qQxdFs2UO9Y5avHUrCz0OFaIN4Z/BzJqQ4ccElyBITx21CRmmmE57u/
         OQie+Jbq/AwgY7hJlv0FxfkTc8hf1uHr2YD3b7LpMiSvBF3Hey2YR3sKl4yiuiijRAQw
         +1IxLUxHZxtAIYCGs0Xzv4L+8DsB8B+ifr6A6RdAYCSPwepJmhg3IWMI+3U/2Jh/2r+N
         mQ5cUDAN6u9oVHDNIG2EvL9xx/NQ5CR8S1j0fz3usLHx7yKAwTR1dWJL9qpd5X9ZsgcL
         2K1AjVGuZfmfI5BA0clAq6XgXP79t7EW4o+8HpvzagyWzSuxVoghx5EsHnd30aqG2gDJ
         RHRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=PD4VuSc1;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=PD4VuSc1;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Thu, 26 Apr 2018 08:38:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
Message-ID: <20180426053758.egezzrh7maz2zbhw@mwanda>
References: <9e4fc4a0-370b-9101-2809-4040de58553c@gmail.com>
 <20180424195729.8433-1-k.marinushkin@gmail.com>
 <20180425061638.GA1450@kroah.com>
 <d2690e90-f3ff-8a3a-38bc-edf0a0c7c754@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2690e90-f3ff-8a3a-38bc-edf0a0c7c754@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=603
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260054
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968190615569586?=
X-GMAIL-MSGID: =?utf-8?q?1598785956317171448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg deleted your patch already...

regards,
dan carpenter

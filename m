Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AG47ELv1dT3c+feHZdgRSBuF4KhftFcHxsC6dkY87fiKWFX6aAIomvPI+Ny5c+IZ34CPWTgCsMl5
ARC-Seal: i=1; a=rsa-sha256; t=1521187970; cv=none;
        d=google.com; s=arc-20160816;
        b=dJg/f/6l6WUDgmr1tS0fBl5m/GFKOn76cHajfUAYkCgj0OUIQcZrglBD88w5RnxLUn
         1Tj4RrORnlEwXQsLbqND6oG6UTgvWiG8+fhzxhi5XCLkxhnOfEPiLBw0PuSFXTgW8Pfa
         3PQMSrCl288nwqfO0va+aVawYE9u3t9g0uMUPV/gaDfpembBEe5vdCUuONQBZuRX5bkQ
         FmYvebe9gZUAe8TTZt3Ua0OpCTkHoqGFcxjQaQf4Vemd2fDzRuy1ZvKqtmyiEX0VPe7z
         VUW/ulV1pBxF5gtDABqtbHLvL/zLB1pWIuRmxh07CHlhxc72qKdkk1s/tXAkZPyHdS+Y
         eTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=aCG5Aik5E8OyoGE75hbwU95khNW2+29Takd26FeRr+s=;
        b=zT2akQe/zTmD0DHfwzVgDPMrkRg/F2dOahwG8SB2B9cap7asdxwkL4a8Jpp6pyJOgr
         DRST7honA9tI3/FaerXVkUWSZ6CQMmPP8ZEKEEDBRmsSPY0iYCUt4VUuxhRHeQ6It/73
         9ja1Fd3ls7ROo6w58S5uPa+T2ff8TSgvPwi76bPF3tKcj+5JsCkYmJEfte89+GtTP6Nw
         2c5Tu173qSLbfCK13KYmn4CNd7dPo1ToBuzosfrUpEbVsGx533umU/nvwHqGD5erI+xn
         ZYmU7Vfjv4V1NJHiOQDP7/0S/o9NGPOymhats6bmr9WEi+bmdStWfTLoi3xBQhbYL0AC
         m74A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=KBtlyS6a;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=KBtlyS6a;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 16 Mar 2018 11:12:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Peter Seiderer <ps.report@gmx.net>
Cc: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v4 2/2] media: staging/imx: fill vb2_v4l2_buffer sequence
 entry
Message-ID: <20180316081201.vvr4vplux3jvuwlb@mwanda>
References: <20180315191323.6028-1-ps.report@gmx.net>
 <20180315191323.6028-2-ps.report@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315191323.6028-2-ps.report@gmx.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=581
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160005
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032168787511284?=
X-GMAIL-MSGID: =?utf-8?q?1595081197589626659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

MUCH BETTER!111!Exclamationmark!  Thanks!  :)

regards,
dan carpenter

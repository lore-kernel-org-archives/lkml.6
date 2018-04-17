Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AIpwx4/tj/DY6h7IsoyTxS9iUfFk2OsTZMVVlqFO8Ro0De38Yu2+iQGJK04lTwLH8RyliAtmlvE0
ARC-Seal: i=1; a=rsa-sha256; t=1523943439; cv=none;
        d=google.com; s=arc-20160816;
        b=txtp1LiZ4DcDeMVg9MTmGBVmyIPv9MMYjGZmlDlAUMBZe13rMuF+oO7d/1o9a+hY2f
         7AtkrxmUDOuc7VvFwtCuooceBWB7aEMgLy6+rwewtA538kk3Y0FNtjdrJOx3IKmCYq7p
         E6cxQh+YbiCUud4aF7MMhfA6pdAdnebEOkeV84l5+joVrqYNVsqlX1cbNiw5xxHOQmlN
         zPef9uMbmAdNrnqj7zOx561JtB7tmR5hy8VFa43zKrYOr+/fjLDrji5BADjBbu/irHg9
         batMsqGBCj77x8Ci30kpxk1VU6tphAdnq27zdxdVgRNUEScSkDbGgmNEmWPoR7iHp3mu
         vntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=WHXirgmcIdOknE+cm0AnVf/yRVKJTvrmygwAPJuInUc=;
        b=tDNtJ+tU0+ooubaDSdpN93WGC4xD/+K5vWY/fgLlf7kHED1L9tLiTzJHnsZNvRcETw
         WNwvDQ0VVxXPxrgc5lf05cRhtDe6OSp30rU3US/CmwQD79q+Vd+9XfmkYpR1s075bW1J
         3oF+6ayTyz3ZFonoQCE4buD/r2FzMswTWsImy5muoR+cpCOLyvOJJVyojVHA/IoR7LGz
         JX+ELEEQqyk0+aSR8eNimKMgZ/v0Z0c6Z8ODtI0cs+2hUL1zAZhz/Ki0gdRbdipSYl4l
         G+xmxDDJUIhFh1HiE1br6MVTxCbIN2ajxPI87WVrTt7V2wZfZhQuu6xNc/DyONz+gATc
         Xltw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 4/7] ocxl: Rename pnv_ocxl_spa_remove_pe to clarify it's
 action
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180417020950.21446-5-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 17 Apr 2018 15:37:09 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417020950.21446-5-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041705-0012-0000-0000-000005CBA99C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041705-0013-0000-0000-00001947F1CE
Message-Id: <3a9452b1-c22c-6a0a-b7b9-b77c3b98f6cb@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170050
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957549805591967?=
X-GMAIL-MSGID: =?utf-8?q?1597970516526160964?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 17/04/18 12:09, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The function removes the process element from NPU cache.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>


Hmm, personally I'd suggest pnv_ocxl_spa_clear_cache() because it's just 
a wrapper around the OPAL call of a similar name.

But I don't feel strongly about this at all, so:

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

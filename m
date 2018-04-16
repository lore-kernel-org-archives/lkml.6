Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/66VCeFmcvSmzQqFVCDuO3OlbO+aoIovMGEc0A0Ux0bfYdf0w913+B/fVoyvRx1uPRh1WT
ARC-Seal: i=1; a=rsa-sha256; t=1523901541; cv=none;
        d=google.com; s=arc-20160816;
        b=Gpbz7qyPt1bpOL/cMCqYMrdUnfuLu74GZ3n0KO+eiYwM8H68snr/fH8faOVnNfksso
         famW1WSNJppzOEBdFhC1MBb+a815rkxvgcROcnBf2S0p2PaE/iKKoMPyNZuoK5oBp+tc
         Elrg8VSxTS6ltV9Begi7Zyta70QNVO+OiFcILZcW/IKoK2A++GlCHRRoUc8YblPW1Vu5
         itR8TaVwnAJCh4AimNOjgz9Ot69qPSB3dCTTlQD3DXbSzZbygd6v5+ER/2cBC7SOTVJA
         cG5fBRFmC99zqKsUD3xQG9FbWaJKfOsHKdb6azgAgdd9KYb8umUtxYSjChnbhgGAbRY3
         E9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:reply-to:arc-authentication-results;
        bh=4+uaESaeRJPeltPgJ5IaAf1Gg3fgQL/tbzmtzIAb3Lc=;
        b=I2cG9qp1HeEp/ZAZFwPFlwSB6rCWROD0wu6wBJgHqv1UKhUf/86REvYolMiA3cuetW
         Nx3VRBW9lUJzsyxDPpV/Xm77Rgt7yjnwUUwp0Whb79DpKjmvmN91eDtJdSt+Ek3syUb6
         4APSii+LDlStFS3CFU+bReh/9fqR5sbfMBrheFleA8+EFYsL0l/vKGTpmDzRYTDBGgC3
         VupV0ZC14KyxD8Y3vcF89ULaMqU1crbdkhq4ScIf/YWe1SFk9JwMDwg4Xzr7k6X/pqTY
         8nW0wKhdnF0twwV52uLNUIcgcUrn8JjFU/jv+rc1SN13TuUfw/zlChG7NXxY+6CmZbbX
         lUhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of sathyanarayanan.kuppuswamy@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=sathyanarayanan.kuppuswamy@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of sathyanarayanan.kuppuswamy@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=sathyanarayanan.kuppuswamy@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,459,1517904000";
   d="scan'208";a="217022509"
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/1] usb: core: Add quirk for HP v222w 16GB Mini
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
 heikki.krogerus@intel.com, felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 sathyaosid@gmail.com, Kamil Lulko <kamilx.lulko@intel.com>
References: <9bc2d73d74474258be14ec6a3fe243354e247679.1523640999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c6569b4d-052f-bb9b-4e05-35dd29a067ee@cogentembedded.com>
From: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <488e8a79-06c7-aff3-314e-59ceea6006c0@linux.intel.com>
Date: Mon, 16 Apr 2018 10:58:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c6569b4d-052f-bb9b-4e05-35dd29a067ee@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597653691859765649?=
X-GMAIL-MSGID: =?utf-8?q?1597926583332068582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Segei,


On 04/14/2018 01:35 AM, Sergei Shtylyov wrote:
> Please indent with tabs (as above and below), not spaces. 
Thanks for the comments. I will fix it in v2.

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

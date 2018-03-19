Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AG47ELuERG8VfKfBo3Z+xEY/7Wfyu8cNgopeoyo6BKabC4HOlKN8H7wz46OO4RF1JFdBQdTZkJPA
ARC-Seal: i=1; a=rsa-sha256; t=1521463910; cv=none;
        d=google.com; s=arc-20160816;
        b=KEq24A/w4dqsgBg7pw6iot21cONUq24OgUYN1X/E78g+2+LsOfYb6wcgq4HfFqJgd7
         eX7sXBvNUWXgQv0Z+n45ADWnHLlZsNXaKtdK4nXZOn73801Dor+ItA495QPfh5pOx1hP
         DQ9+gbqRzIAnOpEI/m0/8PMJ4fBOxYLrk1oa46mbKZDcF+ctdkdhscti30GnqMe6ybCN
         NVhpqrvhRQ0r4AVjm68sNV0RSE8QysE/kgVFI8LZ9hpbQK+EqYd2qCA/nMSWOnlGgEU0
         7r+yFdea6OirilEikn0Le2rtraadHpQ6naGDWEw4o5ZzPBN+U+iSd+YPEuzoCnnT9OjP
         ysnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=R6s1u63vovCegeyH/OAl08/x20GB/H6tYJXEwCD3uns=;
        b=EVaZ5YdWVsJeoE0UuQYOaYWluQ+j+wGvQb6zY2zrFUEYwiO60BldJ+8vuWkhqBThRD
         xc1jnbg0h9x4GDmC2O2LbCUq03Mi0TejadFzOd3lLQdy/PvdfyG9g9dYTOb1TRk1W7iw
         admYW16cR89tcGkpLFupMQlzgvOfRE+UxjZreM4xiVxJRRaCqSGxAizTn78xP4U1Vx3Y
         ZkdiJjsaWpD7BQa0katabE0vwL05Tn5b04OesyN4KQeKMCmKyvXBd08+FglRYxqXvH3d
         pBuNuJNgrWObe5wHmuYnwYTdI9wrcb5tUu4IS2+lTN+wLqgzwVLqj5C4p6UIkFkiUUui
         U3eg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=gQePTQaY;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.1.105 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=gQePTQaY;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.1.105 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 04/21] eeprom: at24: use SPDX identifier instead of GPL
 boiler-plate
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-i2c <linux-i2c@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180319091721.18193-1-brgl@bgdev.pl>
 <20180319091721.18193-5-brgl@bgdev.pl>
 <b1602ac6-04cd-a415-ee66-79533a5af4a3@axentia.se>
 <CAMRc=MdwmCr+OW-_DgKretCmTHc9oukODwN+Mw6FcaUuSD9nCg@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <2c828644-8797-2ec7-fbd7-a6ef21fa1356@axentia.se>
Date: Mon, 19 Mar 2018 13:51:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdwmCr+OW-_DgKretCmTHc9oukODwN+Mw6FcaUuSD9nCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0207.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::31) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f0b5a47-7eed-4f7a-dbed-08d58d982cd9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:RUSsWK58r+8K5ggupLSeIDOaJVGnlqI9H9oEetj0N0sAoi8CUsf+393ITVV8G5pW2SLHa5zy8v55hf04wu9uQRKKgqtaSYiMC+KYlgRFI2c+FThYqVXcWPxYpn7pakjpNXo9ew2J+80x2U+OsoETl9hoWCK+IobZx25/YlGIvmvya2CdABwFJpTbolpui2A/E67gqzWJM9qnoYM/fZKgA4XekvlzISwMayYgNv0q250+1f9T27NXt5ElEMaBIBi2;25:guZ7EdWTgdaK4/rs6VAP/LcONZcDFJO7VTAu8QqY0HVhUSoESyclvG6vuXbwkeHdZvaF8CKtQS/GoBOUPfpUNPoeCWD7QcioCVMkXdSJQr5vJKCUh0Js47GcneTwhH+Jcb/9W2Co4xJfBQzfibgCFArqoqGubdanFS6AROeqQvcWJa2UQBUxEaV36enw+35P83jEdDKzoShb8cuzW7VVoVAxqYmz1ZDR+X8nanYvTo/m0O4fjI4NakKH/RqrMmSKMWgsnWNVbr1EB4I5dBdPnj1/3l/EQppygaRKxnmjvUztTGsIsKETGHtbNF39pB0UDYg75j9w9yTcMYzHQnxdIA==;31:BETx+lHciSCXoq+Cb8h9NR7CU7yre9NTfzhJfpfT5cumTqACF/T5i8dOuH7bQLONSqYV+WYvMwxm7M0z8NitH5wd6QtlltsfFU5mBQB7XrjJb8q2sc8R8AnqiIOvCG3Af07FUCCL89z7tnkP3pXQjdnac84RbL/HlENiTY/uHpJGiwtwu6BxWOhw6Kg4H4+vyzmXzoXi30z/CpuQIHwmpSIk8lyhR5Hs6lCN3zAGo+E=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784051EF10D8CE2C935AB58BCD40@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:dERCmuQkP4r2yLP9ARCldJARjprL/VwHmzmPbpCVnrt2hpkTPJKZEQ6Hk+7EnyImwvjD7yRIgDeVyMHvsZCuHmqhp9KnH4Wd3d0GkHoPGqBW3t7eraX9wbth1Ruvko/IMmFeLS69RJLQB9LLfWj6Zb49s2OkWEL+VeChyNYHhGmnr7nMJNnbX22/bZJ6CD0EV6cjd+TDNmtTnoi0118/xkxyHhq/ghSNcRedthTNUdPLe89nohoDcokIWO+Dr4Ioi3Ewg41UHV3S0m+RfkETkw==
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(376002)(39380400002)(346002)(39830400003)(366004)(377424004)(288314003)(189003)(199004)(386003)(305945005)(478600001)(26005)(3260700006)(68736007)(93886005)(230700001)(8936002)(117156002)(186003)(16526019)(77096007)(8676002)(25786009)(6486002)(4326008)(81166006)(81156014)(50466002)(47776003)(65956001)(31696002)(53546011)(105586002)(74482002)(5660300001)(106356001)(53936002)(7736002)(66066001)(65806001)(6246003)(229853002)(6916009)(64126003)(31686004)(97736004)(2486003)(316002)(52116002)(36916002)(23676004)(6666003)(2950100002)(16576012)(65826007)(54906003)(6116002)(86362001)(3846002)(58126008)(52146003)(36756003)(2906002)(76176011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODQ7MjM6eFgxMTNoWUtZa0NLQmdyemlsMUc4ekN4?=
 =?utf-8?B?QzE2aEhCbXU0SWhDSWcxUDdBS0JKNzJTWndjVVU5TmZWMzFXSFlpRG5VQUM4?=
 =?utf-8?B?S1RHUXBueXV0blJaeVg1N0orcVJUOEVKb0ZrelNrZmx6MDdsWmI3eXcwc0pu?=
 =?utf-8?B?bGY1YnVmN296MUNjb04zNkduOC9rb2pwdmxHVlAxRzFpa0NzVDVNSTlDSjJl?=
 =?utf-8?B?c1lUM091ZVRkSEZFRGUrSTVBS2pRaWpzeUVreWY3Nk5XQVhnOUk0SVlBaCtJ?=
 =?utf-8?B?TTBrcVliUlErMmE1WTVaQTdRcmJQZmEvK1hyNThYNCsyNjEvQUdnYkpibzJi?=
 =?utf-8?B?VTRTOTB0N0MxRkRMZzA2SXcveExuRWhLVWZMNmI1emRBRDVTeEhIa0s0eHVH?=
 =?utf-8?B?Z0VBM1BYL3lMR2I1bmU2WmNQK0dsTDVnS3ZrYStHMFgvN1pUVEp5VElkcWpz?=
 =?utf-8?B?ZnFwalJydktmYmg5NHJCRnAwd0FNSzNLaFJQUEZmbU52R01xMmM3UlNhR1hV?=
 =?utf-8?B?eDN0UmM4dW01aG1tN3JmSk4yUFNRTERXZmxqNytZL1dnWFhkcHJDejhDdTFx?=
 =?utf-8?B?ZUlOS2JvYlIrZjk0VEVSSm5MeWJDcEhBblBTR3M0am0yakV0MDRCVGlVZnBT?=
 =?utf-8?B?bjJnWkZaZktzaU02NEo3TUUwT0huTk44Z1M5aTMwNktva3dFN2tpVUZMMEFp?=
 =?utf-8?B?UkpYMXE5TEQzY0szTlFzelJldUJWaVM2Mi9TcFlGZE5sYVgxQTR5bTZyRGQw?=
 =?utf-8?B?YVJGRUVzUllKcVVyeUl5QXdCRTgvaDl2ZDVmWEhiZXg1VWdTL1YyYjkxSFRI?=
 =?utf-8?B?VjdxY2kyeHByS2lPbjRJSEVvbnliZHEzMWJHcVVBU3NUTDJacnNpYmRFUHNH?=
 =?utf-8?B?WWZxbnNIeHlnSEJ2Wit0SGNPMitwT05rOEc5Y3ZESEpDOEdQV0JnVHI1U3hv?=
 =?utf-8?B?N0pwL3BnYzRIUm51U1c1eTFmeG03VU9TZ211eHZRNHc0THhrNk1GWlc4NkdN?=
 =?utf-8?B?WXo2QnJnVi9jaTlBUjA2Si9lYU10aW5BNjlKcGJNWXl1L1BST0pRSFExUDY3?=
 =?utf-8?B?Z3ZPZzQyUDlkdk5CdVZvbEpZcFNyY2ppNytRSW5lUTFaWEpMbnlzQmZDWVVa?=
 =?utf-8?B?Zjc2aXdwU0FhOFZlT1pQWmJSb3VVUVYxN2FPYlRJc2hHcHFsQzZ3UmFoV0ZN?=
 =?utf-8?B?MnZFMlN5c3dNSmhpMzFxYlg3bjRkSlhRN2Z0S1V0blNYaWdaS0UxQ2tmRlZM?=
 =?utf-8?B?YTVJWlFjWFViTXRGOWw3SjhOR0JHb1BHMUQyUVlvZHNBSVpYMmw4U2U0N2I4?=
 =?utf-8?B?T2lOdlJhUnB2djdmamFVRjhxRkUzYzhtWjZLVVdYd1RmcXI4OXExaWpJbUJU?=
 =?utf-8?B?L0lDc3ZaY0hLTWcxZ05XRnBJVE0rK00wTXFRb1VzblJ1YXpQc3BaQnZUVmRZ?=
 =?utf-8?B?K2ZzSGh1Uk40MXJhbUlWcmNxcDU4bWdGa2F1M1Zqd0FCSEZXUDRqaVdENFQ3?=
 =?utf-8?B?cmJyNmUxSU1rVkNLeDg4RThmaEhrQUZZcTVzK2Yzcjhtclp4SXNlNzdIZXIz?=
 =?utf-8?B?WlJpSFVCbFJ6NEFIS1l3R3A4VWl6aXJIbkxMUWtybTZSTnBxMzlrRllQeUxi?=
 =?utf-8?B?cWxVQzl5QzdmTnE0cmh6RnhVUnJaTFE3YzBDOFNjb2srcHNHcDhwQkd3OXBS?=
 =?utf-8?B?WUNaeXZQY0g4b0xSbVdDVXpINGhtdUxMSU8wdUJOcUxkTzdlSkNHeTEzTmZs?=
 =?utf-8?B?WkJMWWJOSXBGQmZrWEhOaHZhMEhPMXJ0aGhCVWxzUkszcWxMMjdaT2k1NmQy?=
 =?utf-8?B?L3RzZGI3YnhTK0NybE5wUFk3VEsycE0zSWlMVk1nbjBFRFQ2bFVLcTlJaWNx?=
 =?utf-8?B?VEF3N3duZFlzNENVcjk4TXJlTFFtZEZ5UjVUdWluT01TZXhVYmZ1QVczWVNZ?=
 =?utf-8?B?YVV3dTlMTVhmTlhmcDEyU0g4Uy9HVWxOUTg2M25ia2Uyekl3cE8zbkpYWTd4?=
 =?utf-8?B?N3M2UVB2ZG9iRlhOWU9aVGlxM2FlZVluY0tmTjdJclRONWhJOEp3S3BNMEh6?=
 =?utf-8?Q?ZRiRNDY6ZPMEkJoD4NSBfr1Y/pQ?=
X-Microsoft-Antispam-Message-Info: nC0Kv5ySUEiL9Zfo2RXzFvMnzfgdiYnWkbIpx1BCgNxeGTpv+TBA6UH2EnW3jU4VPwlHUsNv4g+29CeaI+cheGYvRaL6K25zwOhpCsWiW1t0+6ud5KjtvhiPmsw3k5vEx0Xu0Vc9YsV2h1NesBzycH3tmlhRUxEzMfOEmfiFwaUAsXl6+Adoac0zzHeI4KgD
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:LH1C+qcDTL+1yz8Ga04P1jd3HuzVTtFtbYhVWXjILDsjKaik1eUOE4gEaYJQIMk2x1qzbbvqgJah37dEDegLPkPbNwiT8z8jvglf3bSMciACFsJ7XrwMW74X2JrhLlw7u+dGuHoLswhqVzg1ZaAbFZWTBnR0UY3KJKv2tkgpZVsoDv9y6NRpO75cTN6kIez/W3mdFXd9bjdgFP98O15uCVuj6cdpyJht+JI7W2/FCHPOzQBuQCIXGd9o6sdRyvP/NaVYWoMRC+jaNFNix2FI6etrAusDs0DvrMreH68byukQztycIeNyG6yUFFQEHof4KeZfCCQQwvg8oBZwFgNot7kqohsZsyxdFaog0eGhbUs=;5:rWJy2+ixvh27X+Ze/Fq9GRoKrUEDXD1tq++v7m0++vP/py2M7Ma92lAZcncYzW3f1jRkCHXl13r+7jAEkrQmTvuhWbvxg1jlcPyUBt8yM22Ee2pjKoMOHCrvQtT9F8agAV1FQZSec7/PRnwcNdhfR2xA4MHybHATGYlb3IgjExc=;24:dLoZlQV2yEHbTXkT5x7eZ03/cQj8b3BqYtyXI4T0HCf6k8laQ4qRCPeU8vnMjhWzvVs1/2P8M9bXIa2mQ0eD4/u4z3ynxlDuYIst+dRUZEo=;7:5+rvE9OpY8uoNLVlbowZOREjjEoXImIME2Y0j4gm/Ce+3Z6mDcotZAbtHhkb/CayFKJ3S3Oi/eGWIXjYqjpoB5pO5GeqNrrNk6qhUzXgaNsmxCY1EijITf+ydorRnvnhxWnxuPbnL9CW0lpitm97TI3x2qxtLoeLUSht/h4zuecs7i4vDLXEVK1u7c3/WDAY2Fa7DtLMId4bM5dpGmCk88MNszMFjMVZ727e0mI1pR3FKB4+B0gwBwoqXHG6bUQN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 12:51:46.4188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0b5a47-7eed-4f7a-dbed-08d58d982cd9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357056282465424?=
X-GMAIL-MSGID: =?utf-8?q?1595370541526653558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-19 13:12, Bartosz Golaszewski wrote:
> 2018-03-19 12:03 GMT+01:00 Peter Rosin <peda@axentia.se>:
>> Also, use a // style comment for the SPDX line in C files.
> 
> I'm seeing both /* */ and // style comments used for SPDX headers - is
> there any reason not to use /* */ here?

Documentation/process/license-rules.rst states:

2. Style:

   The SPDX license identifier is added in form of a comment.  The comment
   style depends on the file type::

      C source: // SPDX-License-Identifier: <SPDX License Expression>
      C header: /* SPDX-License-Identifier: <SPDX License Expression> */
      ASM:      /* SPDX-License-Identifier: <SPDX License Expression> */
      scripts:  # SPDX-License-Identifier: <SPDX License Expression>
      .rst:     .. SPDX-License-Identifier: <SPDX License Expression>
      .dts{i}:  // SPDX-License-Identifier: <SPDX License Expression>

Read more in that file for reasons. If there are none, I personally
think the reason is that "Linus said so". Or something like that?

Cheers,
Peter
